export default defineNuxtConfig({
    compatibilityDate: '2025-07-15',
    devtools: { enabled: true },

    modules: ['@pinia/nuxt', '@nuxt/eslint', 'nuxt-svg-sprite-icon', '@vueuse/nuxt', '@primevue/nuxt-module'],
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

    svgSprite: {
        input: './app/assets/svg',
        output: './app/assets/svg/gen',
        defaultSprite: 'icons',
        elementClass: 'icon',
        optimize: false,
    },
});