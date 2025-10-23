<template>
    <ClientOnly>
        <div
            v-if="useProductsStore().productsList?.length"
            :class="['searchbar', searchbarIsOpen ? 'searchbar--active' : '']"
        >
            <div class="searchbar__container">
                <div class="searchbar__inputbox">
                    <input
                        id="searchbar"
                        ref="inputRef"
                        v-model="inputModel"
                        class="searchbar__input"
                        type="text"
                        placeholder="Найти букет"
                        @input="onInput"
                    />
                    <button
                        class="searchbar__icon"
                        @click="
                            ((searchbarIsOpen = searchbarIsOpen ? false : true), inputSetFocus())
                        "
                    >
                        <SvgSprite type="search" />
                    </button>
                </div>
                <div v-if="searchbarIsOpen && inputModel !== ''" class="searchbar__result">
                    <div
                        v-if="!searchResult?.length && inputModel !== '' && !isLoading"
                        class="searchbar__result-empty"
                    >
                        <span class="searchbar__result-empty-text">
                            К сожалению совпадений не найдено, но...
                        </span>
                        <span class="searchbar__result-empty-text">
                            Вы можете поискать в каталоге
                        </span>
                        <NuxtLink class="searchbar__result-empty-button" :to="{ name: 'index' }">
                            <span>Перейти</span>
                            <span><SvgSprite type="arrow" :size="16" /></span>
                        </NuxtLink>
                    </div>
                    <div
                        v-if="!searchResult?.length && inputModel !== '' && isLoading"
                        class="searchbar__result-loading"
                    >
                        <span></span>
                    </div>

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
                                            product.images[0] ||
                                            '/img/service/flowers-placeholder.png'
                                        "
                                        :alt="product.title"
                                    />
                                </picture>
                                <div class="searchbar__result-item-content">
                                    <p class="searchbar__result-item-title">{{ product.title }}</p>
                                    <span class="searchbar__result-item-id">{{ product.id }}</span>
                                    <span class="searchbar__result-item-price">
                                        {{ product.price }}
                                        <span class="ruble"></span>
                                    </span>
                                </div>
                            </NuxtLink>
                        </li>
                    </ul>
                    <div
                        v-if="searchResult?.length && searchResult?.length === 5"
                        class="searchbar__result-overflow"
                    >
                        <NuxtLink
                            class="searchbar__result-overflow-link"
                            :to="{ name: 'catalog-category', params: { category: 'flowers' } }"
                        >
                            <span>Показать все</span>
                            <SvgSprite type="chevron" :size="16" />
                        </NuxtLink>
                    </div>
                </div>
            </div>
        </div>
    </ClientOnly>
</template>

<script setup lang="ts">
    // types===============================================
    import type { IProduct } from '~/interfaces/product';
    // ====================================================

    const searchbarIsOpen = ref(false);
    const inputRef = ref<HTMLInputElement | null>(null);
    const inputModel = ref<string>('');
    const searchResult = ref<IProduct[] | null>(null);
    const isLoading = ref<boolean>(false);

    const productsStore = useProductsStore();

    function inputSetFocus() {
        if (searchbarIsOpen.value) {
            inputRef.value?.focus();
        } else return;
    }
    const search = useDebounceFn(async () => {
        searchResult.value = (await productsStore.searchProductsFuzzy(inputModel.value)).slice(
            0,
            5
        );
        isLoading.value = false;
    }, 300);

    const onInput = () => {
        isLoading.value = true;
        search();
    };
</script>

<style lang="scss" scoped>
    @use '~/assets/scss/abstracts' as *;

    .searchbar {
        $p: &;

        position: relative;
        width: rem(32);
        aspect-ratio: 1;
        &--active {
            #{$p}__inputbox {
                gap: rem(16);
                padding: 0 rem(8);
                background-color: rgba($c-D4E1E7, 0.05);
            }
            #{$p}__input {
                flex: 0 0 lineScale(480, 320, 480, 1440);
                padding: rem(16) rem(24);
            }
            #{$p}__icon {
                @media (pointer: fine) {
                    &:hover {
                        &::before {
                            scale: 1.5;
                            opacity: 0;
                        }
                    }
                }
            }
        }
        &__container {
            position: absolute;
            z-index: 2;
            top: 50%;
            right: 0;
            translate: 0 -50%;
            background-color: $c-secondary;
        }
        &__inputbox {
            display: flex;
            align-items: center;
            border-radius: rem(32);
            transition: padding $td $tf;

            // initial state
            gap: rem(0);
            padding: 0;
        }
        &__input {
            color: $c-98BBD7;
            font-weight: $fw-semi;
            background: transparent;
            min-width: 0;
            transition: flex $td $tf;

            // initial state
            flex: 0 0 0px;
            padding: 0;

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
        &__icon {
            cursor: pointer;
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            @include frame-scale($border-radius: 0, $padding: rem(8), $finally-border-radius: 50%);
        }
        &__result {
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            background-color: inherit;
            padding: rem(32);
            border-radius: 0 0 rem(32) rem(32);
            overflow: hidden;
            &-list {
                display: flex;
                flex-direction: column;
                gap: rem(16);
            }
            &-item {
                color: $c-FFFFFF;
                &-wrapper {
                    display: grid;
                    grid-template-columns: max-content auto;
                    gap: rem(24);
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
                        'price price';
                    gap: rem(8);
                    padding: rem(12) 0;
                    opacity: 0.8;
                }
                &-title {
                    grid-area: title;
                    font-size: lineScale(22, 20, 480, 1440);
                    font-weight: $fw-semi;
                }
                &-id {
                    grid-area: id;
                    max-width: 8ch;
                    font-size: rem(14);
                    opacity: 0.5;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }
                &-price {
                    grid-area: price;
                }
            }
            &-loading {
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
                > span {
                    position: relative;
                    display: block;
                    width: rem(40);
                    aspect-ratio: 1;
                    &::before {
                        content: '';
                        position: absolute;
                        inset: 0;
                        border-radius: 50%;
                        border: {
                            top: rem(2) solid $c-accent;
                            right: rem(2) solid transparent;
                        }
                        animation: loader 1s linear infinite;
                    }
                }
                @keyframes loader {
                    to {
                        rotate: 360deg;
                    }
                }
            }
            &-empty {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
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

    @media (max-width: 590px) {
        .searchbar {
            $p: &;

            &--active {
                #{$p}__container {
                    position: fixed;
                    z-index: 10;
                    top: 0;
                    width: 100%;
                    translate: initial;
                    padding: rem(16);
                }
                #{$p}__input {
                    flex: initial;
                    width: 100%;
                }
            }
        }
    }
</style>
