import { parsePhoneNumberWithError } from 'libphonenumber-js';
import { getDirectusCollection, createDirectusItem } from '~~/server/services/serverCms';

// types
import type { IOtp } from '~~/interfaces/entities/otp';
import type { PhoneNumber, CountryCode } from 'libphonenumber-js';

const config = useRuntimeConfig();

const smsruApiId = config.smsru.id;
const smsruFrom = config.smsru.from;
const phoneCountry = config.smsru.phoneCountry as CountryCode;
const phoneFormat = config.smsru.phoneFormat as
    | 'NATIONAL'
    | 'INTERNATIONAL'
    | 'E.164'
    | 'RFC3966'
    | 'IDD';

export default defineEventHandler(
    async (event): Promise<{ status: number; error?: string; success: boolean }> => {
        const { phone } = await readBody<{ phone: string }>(event);

        let parsedPhone: PhoneNumber;

        try {
            parsedPhone = parsePhoneNumberWithError(phone, phoneCountry);
            if (!parsedPhone.isValid()) {
                return { status: 400, error: 'Invalid phone number', success: false };
            }
        } catch {
            return { status: 500, error: 'Phone validation error', success: false };
        }
        const formattedPhone = parsedPhone.format(phoneFormat);

        const existingOtps = await getDirectusCollection<IOtp[]>('otp_codes', {
            filter: { phone: { _eq: formattedPhone } },
            sort: '-date_created',
            limit: 1,
        });

        const lastOtp = Array.isArray(existingOtps) ? existingOtps[0] : null;

        // 1 min cooldown
        if (lastOtp && new Date(lastOtp.date_created).getTime() > Date.now() - 60 * 1000) {
            return { status: 429, error: 'Cooldown: wait 1 minute', success: false };
        } else if (lastOtp && new Date(lastOtp.date_created).getTime() < Date.now() - 60 * 1000) {
            return { status: 208, error: 'Otp already exists', success: false };
        }

        const otpCode = Math.floor(100000 + Math.random() * 900000).toString(); // 6 digits

        const createOtp = await createDirectusItem<IOtp>('otp_codes', {
            phone: formattedPhone,
            code: otpCode,
            expires_at: new Date(Date.now() + 5 * 60 * 1000).toISOString(),
            attempts: 0,
        });
        if (!createOtp) {
            return { status: 500, error: 'Failed to create OTP', success: false };
        }

        // test
        const smsUrl = `https://sms.ru/sms/send?api_id=${smsruApiId}&to=${formattedPhone}&msg=Ваш код для входа на сайт: ${otpCode}&from=${smsruFrom}&test=1&json=1}`;
        const smsRes = await fetch(smsUrl);
        const smsResult = await smsRes.text();
        console.log(smsResult);

        console.log('Ваш код для входа на сайт (dev):', otpCode);

        return { status: 200, success: true };
    }
);
