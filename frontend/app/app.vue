<template>
    <NuxtPage />
    <ModalsContainer />
</template>

<script setup lang="ts">
    import { ModalsContainer } from 'vue-final-modal';

    // data ========================================================
    const productsStore = useProductsStore();

    productsStore.getProducts();
    // =============================================================

    // SEO & Meta ==================================================
    useHead({
        title: 'Arabeska - Магазин цветов в Самаре',
        htmlAttrs: {
            lang: 'ru',
        },
        link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.svg' }],
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
