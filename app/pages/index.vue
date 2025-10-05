<template>
    <NuxtLayout>
        <!-- <HomeHero /> -->
        <!-- {{ status }} -->
        <HomeCarousel
            title="В тренде"
            :content-ref="toRef(productsList)"
            :status-ref="toRef(productsStatus)"
            :wtith-controls="false"
            :wtith-link="false"
            card-variant="large"
        />
    </NuxtLayout>
</template>

<script setup lang="ts">
    import type { AsyncDataRequestStatus } from '#app';
    import type { IProduct } from '~/interfaces/product';

    // data
    // const { data: productsList, status: productsStatus } = await useApiStore().fetchData<IProduct[]>('/products',);

    const productsList = useState('products', () => [] as IProduct[]);
    const productsStatus = useState('status', () => '' as AsyncDataRequestStatus);

    const data = useLazyFetch<IProduct[]>('http://localhost:3001/products', {
        default: () => [],
    });

    productsList.value = data.data.value;
    productsStatus.value = data.status.value;

    console.log(isRef(productsList));
    console.log(isRef(productsStatus));
</script>
