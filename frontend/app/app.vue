<template>
    <NuxtPage />
    <ModalsContainer />
</template>

<script setup lang="ts">
    import { ModalsContainer } from 'vue-final-modal';
    // data ========================================================
    const productsStore = useProductsStore();
    const cartStore = useCartStore();

    await productsStore.getProducts();
    await cartStore.initCart();
    // =============================================================

    // SEO & Meta ==================================================
    useHead({
        title: 'Arabeska - Магазин цветов в Самаре',
        htmlAttrs: {
            lang: 'ru',
        },
        link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.svg' }],
        meta: [
            { name: 'theme-color', content: '#082535' },
            { name: 'robots', content: 'index, follow' },
            { property: 'og:type', content: 'website' },
        ],
    });
    // =============================================================
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    html,
    body {
        color: $c-secondary;
    }
</style>
