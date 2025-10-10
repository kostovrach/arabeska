<template>
    <NuxtPage />
</template>

<script setup lang="ts">
    const productsStore = useProductsStore();
    productsStore.getProducts();
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    html,
    body {
        color: $c-secondary;
        overflow-x: clip;
    }
</style>
