<template>
    <NuxtLayout>
        <div v-show="singleProductStatus === 'pending'">Загрузка...</div>
        <div v-show="singleProductStatus === 'success'">{{ productsItem }}</div>
    </NuxtLayout>
</template>

<script setup lang="ts">
    const route = useRoute().params.id;
    const productsStore = useProductsStore();

    productsStore.getProductById(route);

    const { productsItem, singleProductStatus } = storeToRefs(productsStore);
</script>

<style scoped></style>
