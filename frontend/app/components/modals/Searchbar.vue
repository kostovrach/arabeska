<template>
    <VueFinalModal overlay-transition="vfm-fade" content-transition="vfm-slide-up" @opened="inputSetFocus">
        <div class="searchbar">
            <div class="searchbar__head">
                <div class="searchbar__inputbox">
                    <input
                        ref="inputRef"
                        id="searchbar"
                        class="searchbar__input"
                        type="text"
                        name="searchbar"
                        placeholder="Найти букет"
                        v-model="inputModel"
                        @input="onInput"
                    />
                    <button class="searchbar__close-btn" type="button" @click="emit('close')">
                        <SvgSprite type="cross" :size="24" />
                    </button>
                </div>
            </div>
            <div v-if="inputModel" class="searchbar__result">
                <div
                    v-if="!searchResult?.length && inputModel && !isLoading"
                    class="searchbar__result-empty"
                >
                    <span class="searchbar__result-empty-text">
                        К сожалению совпадений не найдено, но...
                    </span>
                    <span class="searchbar__result-empty-text">Вы можете поискать в каталоге</span>
                    <NuxtLink
                        class="searchbar__result-empty-button"
                        :to="{ name: 'catalog-category', params: { category: 'bukety' } }"
                    >
                        <span>Перейти</span>
                        <span><SvgSprite type="arrow" :size="16" /></span>
                    </NuxtLink>
                </div>
                <LoadSpinner
                    v-if="!searchResult?.length && inputModel && isLoading"
                    class="searchbar__result-loading"
                ></LoadSpinner>
                <ul class="searchbar__result-list">
                    <li
                        v-for="product in searchResult"
                        :key="product.id"
                        class="searchbar__result-item"
                    >
                        <NuxtLink
                            class="searchbar__result-item-wrapper"
                            :to="{ name: 'product-id', params: { id: product.id } }"
                        >
                            <picture class="searchbar__result-item-image-container">
                                <img
                                    :src="
                                        `${cmsUrl}/assets/${product.images[0]?.directus_files_id.id}` ||
                                        '/img/service/flowers-placeholder.png'
                                    "
                                    :alt="product.title"
                                />
                            </picture>
                            <div class="searchbar__result-item-content">
                                <p class="searchbar__result-item-title">{{ product.title }}</p>
                                <span class="searchbar__result-item-id">арт. {{ product.id }}</span>
                                <p
                                    v-if="product.structure?.length"
                                    class="searchbar__result-item-desc"
                                >
                                    {{
                                        product.structure
                                            ?.map((el) => el.structure_id?.name)
                                            .join(', ')
                                    }}
                                </p>

                                <ul class="searchbar__result-item-price">
                                    <li
                                        v-if="product.discount"
                                        class="searchbar__result-item-price-crossed"
                                    >
                                        <span class="ruble">
                                            {{ product.price.toLocaleString('ru-RU') }}
                                        </span>
                                    </li>
                                    <li class="searchbar__result-item-price-current">
                                        <span class="ruble">
                                            {{
                                                product.discount
                                                    ? product.discount.toLocaleString('ru-RU')
                                                    : product.price.toLocaleString('ru-RU')
                                            }}
                                        </span>
                                    </li>
                                </ul>
                            </div>
                        </NuxtLink>
                    </li>
                </ul>
                <div
                    v-if="searchResult?.length && searchResult?.length >= 7"
                    class="searchbar__result-overflow"
                >
                    <NuxtLink
                        class="searchbar__result-overflow-link"
                        :to="{ name: 'catalog-category', params: { category: 'bukety' } }"
                    >
                        <span>Показать все</span>
                        <SvgSprite type="chevron" :size="16" />
                    </NuxtLink>
                </div>
            </div>
        </div>
    </VueFinalModal>
</template>

<script setup lang="ts">
    // types===============================================
    import type { IProduct } from '~~/interfaces/entities/product';
    // ====================================================

    import { VueFinalModal } from 'vue-final-modal';

    const emit = defineEmits<{
        (e: 'close'): void;
        (e: 'open'): void;
    }>();

    const cmsUrl = useRuntimeConfig().public.apiBase;

    const inputRef = ref<HTMLInputElement | null>(null);
    const inputModel = ref<string>('');
    const searchResult = ref<IProduct[] | null>(null);
    const isLoading = ref<boolean>(false);

    const productsStore = useProductsStore();

    const inputSetFocus = (): void => inputRef.value?.focus();

    const search = useDebounceFn(async () => {
        searchResult.value = (await productsStore.searchProductsFuzzy(inputModel.value)).slice(
            0,
            7
        );
        isLoading.value = false;
    }, 300);

    const onInput = () => {
        isLoading.value = true;
        search();
    };
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .searchbar {
        width: 100%;
        height: 100%;
        max-height: 100lvh;
        &__head {
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: $c-secondary;
            @include content-container;
        }
        &__inputbox {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: lineScale(16, 4, 480, 1440);
            padding: rem(16) 0;
        }
        &__input {
            color: $c-98BBD7;
            width: 100%;
            max-width: rem(768);
            padding: rem(16) rem(24);
            background-color: rgba($c-D4E1E7, 0.05);
            border: rem(1) solid rgba($c-98BBD7, 0.25);
            border-radius: rem(32);
            &:focus {
                outline: none;
            }
            &::placeholder {
                color: inherit;
                font-size: inherit;
                font-weight: inherit;
                opacity: 0.5;
            }
        }
        &__close-btn {
            color: $c-FFFFFF;
            @include close-button;
        }
        &__result {
            width: 100%;
            height: 100%;
            background-color: $c-secondary;
            padding: rem(32) 0;
            border-radius: 0 0 rem(32) rem(32);
            overflow: hidden;
            &-list {
                height: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                overflow-y: auto;
            }
            &-item {
                position: relative;
                width: 100%;
                max-width: rem(860);
                color: $c-FFFFFF;
                &:not(:first-child) {
                    border-top: rem(1) solid rgba($c-98BBD7, 0.25);
                }
                &::before {
                    content: '';
                    position: absolute;
                    z-index: 0;
                    inset: 0;
                    border-radius: rem(4);
                    background-color: $c-98BBD7;
                    opacity: 0;
                    pointer-events: none;
                }
                @media (pointer: fine) {
                    &:hover {
                        &::before {
                            opacity: 0.05;
                        }
                    }
                }
                &-wrapper {
                    display: grid;
                    grid-template-columns: max-content auto;
                    align-items: center;
                    gap: rem(24);
                    padding: rem(8) rem(16);
                }
                &-image-container {
                    width: rem(80);
                    aspect-ratio: 1;
                    border-radius: rem(16);
                    overflow: hidden;
                    img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                    }
                }
                &-content {
                    width: 100%;
                    height: 100%;
                    display: grid;
                    justify-content: space-between;
                    align-content: space-between;
                    grid-template-areas:
                        'title id'
                        'desc price';
                    gap: rem(8) rem(16);
                    padding: rem(12) 0;
                    opacity: 0.8;
                }
                &-title {
                    grid-area: title;
                    font-size: lineScale(22, 20, 480, 1440);
                    font-weight: $fw-semi;
                    text-wrap: balance;
                }
                &-id {
                    grid-area: id;
                    text-align: right;
                    font-size: rem(14);
                    opacity: 0.5;
                    white-space: nowrap;
                }
                &-desc {
                    grid-area: desc;
                    max-width: 45ch;
                    font-size: rem(14);
                    line-height: 1.4;
                    opacity: 0.5;
                    @include lineClamp(2);
                }
                &-price {
                    grid-area: price;
                    display: flex;
                    flex-direction: column;
                    &-crossed {
                        position: relative;
                        align-self: flex-end;
                        width: fit-content;
                        font-size: rem(12);
                        opacity: 0.5;
                        &::before {
                            content: '';
                            position: absolute;
                            top: 50%;
                            left: 50%;
                            translate: -50% -50%;
                            width: 110%;
                            height: rem(2);
                            background-color: $c-accent;
                            rotate: -8deg;
                        }
                    }
                }
            }
            // &-loading {
            //     width: 100%;
            //     display: flex;
            //     align-items: center;
            //     justify-content: center;
            //     > span {
            //         position: relative;
            //         display: block;
            //         width: rem(40);
            //         aspect-ratio: 1;
            //         &::before {
            //             content: '';
            //             position: absolute;
            //             inset: 0;
            //             border-radius: 50%;
            //             border: {
            //                 top: rem(2) solid $c-accent;
            //                 right: rem(2) solid transparent;
            //             }
            //             animation: loader 1s linear infinite;
            //         }
            //     }
            //     @keyframes loader {
            //         to {
            //             rotate: 360deg;
            //         }
            //     }
            // }
            &-empty {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                color: $c-FFFFFF;
                &-text {
                    font-size: rem(16);
                    line-height: 1.4;
                    opacity: 0.5;
                }
                &-button {
                    margin-top: rem(24);
                    @include button-primary(
                        $font-size: rem(14),
                        $padding: rem(12) rem(32),
                        $gap: rem(16),
                        $anim-color: $c-accent
                    );
                }
            }
            &-overflow {
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: $c-FFFFFF;
                padding: rem(16) 0 0;
                &-link {
                    display: flex;
                    align-items: center;
                    gap: rem(6);
                    opacity: 0.8;
                    @media (pointer: fine) {
                        &:hover {
                            color: $c-FFFFFF;
                        }
                    }
                }
            }
        }
    }
</style>
