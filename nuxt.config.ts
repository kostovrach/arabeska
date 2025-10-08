export default defineNuxtConfig({
    compatibilityDate: '2025-07-15',
    devtools: { enabled: true },

    modules: ['@pinia/nuxt', '@nuxt/eslint', 'nuxt-svg-sprite-icon', 'nuxt-swiper'],
    css: ['~/assets/css/main.css'],

    typescript: {
        strict: true,
        typeCheck: true,
    },

    runtimeConfig: {
        public: {
            apiBase: 'http://localhost:3001',
        },
    },

    app: {
        head: {
            title: 'Arabeska - Магазин цветов в Самаре',
            htmlAttrs: {
                lang: 'ru',
            },
            link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.svg' }],
        },
    },

    svgSprite: {
        input: './app/assets/svg',
        output: './app/assets/svg/gen',
        defaultSprite: 'icons',
        elementClass: 'icon',
        optimize: false,
    },
});
