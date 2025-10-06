<template>
    <NuxtLayout>
        <HomeHero />
        <HomeCarousel
            title="В тренде"
            :content-ref="ref(popularproducts)"
            :status-ref="ref(productsStatus)"
            :wtith-link="false"
            :autoplay="true"
            card-variant="large"
        />
        <HomeCarousel title="Бестселлеры" :content-ref="ref(bestsellerProducts)" :status-ref="ref(productsStatus)" />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { IProduct } from '~/interfaces/product';

    // data=================================================
    const productsStore = useProductsStore();
    await productsStore.getProducts();

    const { productsList, productsStatus } = storeToRefs(productsStore);

    const popularproducts: IProduct[] = (productsList.value ?? []).filter((el) => el.popular);
    const bestsellerProducts: IProduct[] = (productsList.value ?? []).filter((el) => el.bestseller);
    //======================================================
</script>
