export default defineNuxtConfig({
    compatibilityDate: '2025-07-15',
    ssr: true,

    typescript: {
        strict: true,
        typeCheck: true,
    },

    nitro: {
        preset: 'node-server',
    },

    routeRules: {
        '/profile': { ssr: false },
        '/cart': { ssr: false },
        '/checkout': { ssr: false },
    },

    runtimeConfig: {
        public: {
            cmsUrl: process.env.DIRECTUS_URL || '',
            siteUrl: process.env.SITE_URL || '',
            appEnv: (process.env.APP_ENV || 'prod') as 'dev' | 'prod',
        },
        directus: {
            url: process.env.DIRECTUS_URL || '',
            readToken: process.env.DIRECTUS_READ_TOKEN || '',
            crudToken: process.env.DIRECTUS_CRUD_TOKEN || '',
        },
        auth: {
            phoneCountry: process.env.PHONE_COUNTRY || 'RU',
            phoneFormat: process.env.PHONE_FORMAT || 'E.164',
        },
        jwt: {
            secret: process.env.JWT_SECRET || '',
        },
        smtp: {
            host: process.env.SMTP_HOST || '',
            port: process.env.SMTP_PORT || '465',
            user: process.env.SMTP_USER || '',
            pass: process.env.SMTP_PASS || '',
        },
        amo: {
            domain: process.env.AMO_DOMAIN || '',
            clientId: process.env.AMO_CLIENT_ID || '',
            clientSecret: process.env.AMO_CLIENT_SECRET || '',
            redirectUri: process.env.AMO_REDIRECT_URI || '',
            bearer: process.env.AMO_BEARER || '',
        },
    },

    modules: [
        '@pinia/nuxt',
        '@nuxt/eslint',
        'nuxt-svg-sprite-icon',
        '@vueuse/nuxt',
        '@primevue/nuxt-module',
        '@vue-final-modal/nuxt',
        'vue-yandex-maps/nuxt',
    ],
    css: ['vue-final-modal/style.css', '~/assets/css/main.css'],

    svgSprite: {
        input: './app/assets/svg',
        output: './app/assets/svg/gen',
        defaultSprite: 'icons',
        elementClass: 'icon',
        optimize: false,
    },

    yandexMaps: {
        apikey: process.env.YANDEX_API_KEY,
        servicesApikeys: {
            suggest: process.env.YANDEX_SUGGEST_KEY,
        },
        strictMode: true,
        lang: 'ru_RU',
        version: 'v3',
    },

    build: {
        transpile: ['@fancyapps/ui', 'fancyapps-ui'],
    },
    alias: {
        'fancyapps-ui': './@fancyapps/ui/dist/index.esm.js',
    },
});
