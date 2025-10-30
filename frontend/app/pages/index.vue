<template>
    <NuxtLayout>
        <HomeHero />
        <!-- <HomeCarousel
            title="В тренде"
            :content-ref="ref(popularproducts)"
            :status-ref="ref(productsStatus)"
            :wtith-link="false"
            :autoplay="true"
        /> -->
        <HomeCarousel
            title="Бестселлеры"
            :content-ref="ref(productsList)"
            :status-ref="ref(productsStatus)"
        />
        <HomeCarousel
            title="Акции"
            :content-ref="ref(discountProducts)"
            :status-ref="ref(productsStatus)"
        />
        <!-- <HomeCarousel
            title='Не знаешь что подарить<span class="symbol">?</span> Подари выбор<span class="symbol">!</span>'
            :content-ref="ref(certificatesList)"
            :status-ref="ref(certificatesStatus)"
        /> -->
        <HomeBanner />
        <HomeAdvant />
        <HomeFeedback />
        <HomeMap />
    </NuxtLayout>
</template>

<script setup lang="ts">
    // data=================================================
    // products
    const productsStore = useProductsStore();
    // Вызов основного метода происходит в app.vue

    const { productsList, productsStatus } = storeToRefs(productsStore);

    // const popularproducts = computed(() => (productsList.value ?? []).filter((el) => el.popular));

    // const bestsellerProducts = computed(() =>
    //     (productsList.value ?? []).filter((el) => el.bestseller)
    // );

    const discountProducts = computed(() =>
        (productsList.value ?? []).filter((el) => el.discount && el.discount !== 0)
    );
    //======================================================
</script>
