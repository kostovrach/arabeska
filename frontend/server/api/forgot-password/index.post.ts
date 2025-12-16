import validator from 'validator';
import crypto from 'crypto';
import nodemailer from 'nodemailer';
import {
    getDirectusCollection,
    createDirectusItem,
    updateDirectusItem,
} from '~~/server/services/serverCms';

// types
import type { H3Event, EventHandlerRequest } from 'h3';
import type { IUser } from '~~/interfaces/entities/user';
import type { IRateLimit } from '~~/interfaces/entities/rate-limit';
import type { IResetOtp } from '~~/interfaces/entities/reset-otp';

const config = useRuntimeConfig();
const isDev = config.public.appEnv === 'dev';

const SITE_URL = config.public.siteUrl;

const MAX_ATTEMPTS: number = 5;
const COOLDOWN_MINUTES: number = 2;
const OTP_EXPIRATION: number = 60 * 60 * 1000;

const SMTP_HOST = config.smtp.host;
const SMTP_PORT = Number(config.smtp.port);
const SMTP_USER = config.smtp.user;
const SMTP_PASS = config.smtp.pass;
const SMTP_SECURE: boolean = true;

let transporter: nodemailer.Transporter | undefined;

// email template
const emailTemplate = `
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Восстановление пароля</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; background-color: #fff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .header { text-align: center; padding: 10px 0; }
        .header img { max-width: 150px; }
        .content { padding: 20px; }
        .code { font-size: 24px; font-weight: bold; color: #007bff; text-align: center; }
        .footer { text-align: center; font-size: 12px; color: #777; padding: 10px 0; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <img src="{site_url}/favicon.svg" alt="Arabeska">
            <h2>Восстановление пароля</h2>
        </div>
        <div class="content">
            <p>Здравствуйте!</p>
            <p>Вы запросили восстановление пароля на сайте {site_url}.</p>
            <p>Ваш код для сброса пароля: <span class="code">{code}</span></p>
            <p>Код действителен в течение 1 часа. Если вы не запрашивали восстановление, игнорируйте это письмо.</p>
        </div>
        <div class="footer">
            <p>© 2025 Arabeska. Все права защищены.</p>
            <p><a href="{site_url}">Перейти на сайт</a></p>
        </div>
    </div>
</body>
</html>
`;

function getClientIp(event: H3Event<EventHandlerRequest>): string {
    const xForwardedFor = event.node.req.headers['x-forwarded-for'];
    if (Array.isArray(xForwardedFor)) {
        return xForwardedFor[0] || 'unknown';
    }
    return xForwardedFor?.split(',')[0] || event.node.req.socket.remoteAddress || 'unknown';
}

export default defineEventHandler(
    async (event): Promise<{ status: number; message?: string; success: boolean }> => {
        if (!transporter) {
            if (isDev) {
                const testAccount = await nodemailer.createTestAccount();
                transporter = nodemailer.createTransport({
                    host: 'smtp.ethereal.email',
                    port: 587,
                    secure: false,
                    auth: {
                        user: testAccount.user,
                        pass: testAccount.pass,
                    },
                });
            } else {
                transporter = nodemailer.createTransport({
                    host: SMTP_HOST,
                    port: SMTP_PORT,
                    secure: SMTP_SECURE,
                    auth: {
                        user: SMTP_USER,
                        pass: SMTP_PASS,
                    },
                });
            }
        }

        const { email } = await readBody<{ email: string }>(event);

        if (!validator.isEmail(email)) {
            return { status: 400, message: 'Invalid email', success: false };
        }

        const ip = getClientIp(event);

        // Rate limit
        const rateLimits = await getDirectusCollection<IRateLimit[]>('rate_limits', {
            filter: { ip: { _eq: ip }, type: { _eq: 'forgot' } },
            sort: '-last_attempt',
            limit: 1,
        });
        let rateLimit = Array.isArray(rateLimits) ? rateLimits[0] : null;

        if (rateLimit && rateLimit.attempts >= MAX_ATTEMPTS && rateLimit.last_attempt) {
            const lastTime = new Date(rateLimit.last_attempt).getTime();
            const cooldownEnd = lastTime + COOLDOWN_MINUTES * 60 * 1000;

            if (Date.now() < cooldownEnd) {
                return { status: 429, message: 'Too many requests, please wait', success: false };
            } else {
                await updateDirectusItem<IRateLimit>('rate_limits', rateLimit.id, {
                    attempts: 0,
                    last_attempt: null,
                });
                rateLimit = null;
            }
        }

        if (!rateLimit) {
            rateLimit = await createDirectusItem<IRateLimit>('rate_limits', {
                ip,
                type: 'forgot',
                attempts: 0,
                last_attempt: null,
            });
            if (!rateLimit) {
                return { status: 500, message: 'Server error', success: false };
            }
        }

        const newRateAttempts = rateLimit.attempts++;
        await updateDirectusItem<IRateLimit>('rate_limits', rateLimit.id, {
            attempts: newRateAttempts,
            last_attempt: new Date().toISOString(),
        });

        // Find user
        const users = await getDirectusCollection<IUser[]>('users', {
            filter: { email: { _eq: email } },
            limit: 1,
        });
        const user = Array.isArray(users) ? users[0] : null;

        if (!user) {
            return { status: 200, message: 'If account exist, reset code sent', success: true };
        }

        const existingOtps = await getDirectusCollection<IResetOtp[]>('password_reset_otps', {
            filter: { user_id: { _eq: user.id } },
            sort: '-date_created',
            limit: 1,
        });
        const lastOtp = Array.isArray(existingOtps) ? existingOtps[0] : null;

        if (lastOtp && new Date(lastOtp.date_created).getTime() > Date.now() - 60 * 1000) {
            return { status: 429, message: 'Cooldown: wait 1 minute', success: false };
        }

        // Gen OTP
        const otpCode = crypto.randomInt(100000, 999999).toString();

        // Create OTP
        const createOtp = await createDirectusItem<IResetOtp>('password_reset_otps', {
            user_id: user.id,
            code: otpCode,
            expires_at: new Date(Date.now() + OTP_EXPIRATION).toISOString(),
            attempts: 0,
            date_created: new Date().toISOString(),
        });
        if (!createOtp) {
            return {
                status: 500,
                message: 'Server error: failed to create reset code',
                success: false,
            };
        }

        // Send OTP
        const emailHtml = emailTemplate
            .replace('{code}', otpCode)
            .replaceAll('{site_url}', SITE_URL);

        const mailOptions: nodemailer.SendMailOptions = {
            from: SMTP_USER,
            to: email,
            subject: 'Восстановление пароля от личного кабинета на сайте fs-arabeska.ru',
            html: emailHtml,
        };

        try {
            const info = await transporter.sendMail(mailOptions);
            if (isDev) {
                console.log('Reset code (dev):', otpCode);
                console.log('Preview URL:', nodemailer.getTestMessageUrl(info));
            }
        } catch (err) {
            console.error('Email send error:', err);
            return { status: 500, message: 'Failed to send email', success: false };
        }

        return { status: 200, success: true };
    }
);
