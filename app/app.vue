<template>
    <NuxtPage />
</template>

<script setup lang="ts">
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
        overflow-x: clip;
    }
</style>
