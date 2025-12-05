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

    runtimeConfig: {
        public: {
            cmsUrl: process.env.DIRECTUS_URL || '',
            siteUrl: process.env.SITE_URL || '',
        },
        directus: {
            url: process.env.DIRECTUS_URL || '',
            readToken: process.env.DIRECTUS_READ_TOKEN || '',
            crudToken: process.env.DIRECTUS_CRUD_TOKEN || '',
        },
        smsru: {
            id: process.env.SMSRU_API_ID || '',
            from: process.env.SMSRU_FROM || '',
            phoneCountry: process.env.SMSRU_COUNTRY || 'RU',
            phoneFormat: process.env.SMSRU_FORMAT || 'E.164',
        },
        jwt: {
            secret: process.env.JWT_SECRET || '',
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
