export default defineNuxtConfig({
    compatibilityDate: '2025-07-15',
    devtools: { enabled: true },
    ssr: true,

    typescript: {
        strict: true,
        typeCheck: true,
    },

    nitro: {
        preset: 'vercel',
    },

    runtimeConfig: {
        public: {
            apiBase: '/api',
            // yandexApiKey: process.env.YANDEX_API_KEY || '',
        },
        directus: {
            url: process.env.DIRECTUS_URL || '',
            token: process.env.DIRECTUS_TOKEN || '',
        },
    },

    modules: [
        '@pinia/nuxt',
        '@nuxt/eslint',
        'nuxt-svg-sprite-icon',
        '@vueuse/nuxt',
        '@primevue/nuxt-module',
        '@vue-final-modal/nuxt',
    ],
    css: ['vue-final-modal/style.css', '~/assets/css/main.css'],

    svgSprite: {
        input: './app/assets/svg',
        output: './app/assets/svg/gen',
        defaultSprite: 'icons',
        elementClass: 'icon',
        optimize: false,
    },

    build: {
        transpile: ['@fancyapps/ui', 'fancyapps-ui'],
    },
    alias: {
        'fancyapps-ui': './@fancyapps/ui/dist/index.esm.js',
    },
});
