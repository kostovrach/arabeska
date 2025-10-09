<template>
    <ClientOnly>
        <div :class="['searchbar', searchbarIsOpen ? 'searchbar--active' : '']">
            <div class="searchbar__container">
                <div class="searchbar__inputbox">
                    <input
                        v-model="inputModel"
                        ref="inputRef"
                        id="searchbar"
                        class="searchbar__input"
                        type="text"
                        placeholder="Найти букет (название, повод, артикул...)"
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
                <div class="searchbar__result">
                    <div
                        class="searchbar__result-empty"
                        v-if="!searchResult?.length && inputModel !== ''"
                    >
                        Совпадений не найдено
                    </div>

                    <ul class="searchbar__result-list" v-if="searchResult?.length">
                        <li
                            class="searchbar__result-item"
                            v-for="product in searchResult"
                            :key="product.id"
                        >
                            <NuxtLink
                                class="searchbar__result-item-wrapper"
                                :to="{ name: 'product-id', params: { id: product.id } }"
                            >
                                {{ product.title }}
                            </NuxtLink>
                        </li>
                    </ul>
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

    const productsStore = useProductsStore();

    function inputSetFocus() {
        if (searchbarIsOpen.value) {
            inputRef.value?.focus();
        } else return;
    }

    const onInput = useDebounceFn(async () => {
        searchResult.value = await productsStore.searchProductsFuzzy(inputModel.value);
    }, 200);
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
                flex: 0 0 lineScale(480, 220, 480, 1440);
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
            width: 100%;
            min-height: rem(128);
            background-color: inherit;
            padding: rem(32);
            // margin-top: rem(256);
        }
    }
</style>
