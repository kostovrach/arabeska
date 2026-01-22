<template>
    <NuxtPage />
    <ModalsContainer />
</template>

<script setup lang="ts">
    import { ModalsContainer } from 'vue-final-modal';
    import type { IProduct } from '~~/interfaces/entities/product';
    // data ========================================================

    const { setProducts } = useProductsStore();

    const { content: products } = await useCms<IProduct[]>(
        'products',
        [
            'images.*',
            'images.directus_files_id.*',
            'category.*',
            'category.categories_id.*',
            'reason.*',
            'reason.reason_id.*',
            'style.*',
            'style.styles_id.*',
            'structure.*',
            'structure.structure_id.*',
        ],
        {
            transform: (productsArray) => {
                const result = productsArray.data.filter((product) => product.available === true);

                return { data: result };
            },
        }
    );

    await useCartStore().initCart();
    useViewsStore().initFromLocalStorage();
    // =============================================================

    // Setters =====================================================
    setProducts(products.value ?? []);
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
            { name: 'robots', content: 'noindex, nofollow' },
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
