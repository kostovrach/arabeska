export default defineNuxtConfig({
    compatibilityDate: '2025-07-15',
    devtools: { enabled: true },

    modules: ['@nuxt/eslint', 'nuxt-svg-sprite-icon', 'nuxt-swiper'],
    css: ['~/assets/css/main.css'],

    typescript: {
        strict: true,
        typeCheck: true,
    },

    app: {
        head: {
            title: 'Arabeska',
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