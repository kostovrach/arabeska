<template>
    <section class="faq-delivery">
        <h2 class="faq-delivery__title">{{ props.title }}</h2>
        <ClientOnly>
            <p class="faq-delivery__desc" v-if="props.content" v-html="props.content"></p>
        </ClientOnly>
        <ul class="faq-delivery__info">
            <li v-for="(item, idx) in props.infoBlocks" :key="idx" class="faq-delivery__info-item">
                <h4 class="faq-delivery__info-title" v-if="item.title">{{ item.title }}</h4>
                <div
                    class="faq-delivery__info-content"
                    v-if="item.content"
                    v-html="item.content"
                ></div>
            </li>
        </ul>
        <!-- temp map -->
        <div class="faq-delivery__address">
            <h3 class="faq-delivery__subtitle">Зоны доставки</h3>
            <MapWrapperZones />

            <!-- <div class="faq-delivery__address-validator">
                <FloatLabel
                    class="faq-delivery__address-validator-input"
                    variant="on"
                    autocomplete="off"
                >
                    <InputText id="address-validator" />
                    <label for="address-validator">Введите улицу и № дома</label>
                </FloatLabel>
                <button class="faq-delivery__address-validator-button" type="button">
                    <span>Проверить адрес</span>
                </button>
                <span class="faq-delivery__address-validator-result">
                    ✅ Доставка по указанному адресу возможна
                </span>
            </div> -->

            <!-- <picture class="faq-delivery__address-image">
                <img src="/img/temp/map.jpg" alt="#" />
            </picture> -->
            <div class="faq-delivery__hint" v-html="props.mapFootnote"></div>
        </div>
        <!-- temp map -->

        <div class="faq-delivery__advant" v-if="props.advantCards.length">
            <h3 class="faq-delivery__subtitle" v-if="props.advantTitle">{{ props.advantTitle }}</h3>
            <p class="faq-delivery__desc" v-if="props.advantSubtitle">{{ props.advantSubtitle }}</p>
            <ul class="faq-delivery__advant-list">
                <li
                    v-for="(card, idx) in props.advantCards"
                    :key="idx"
                    class="faq-delivery__advant-item"
                >
                    <h4 v-if="card.title">{{ card.title }}</h4>
                    <div v-if="card.content" v-html="card.content"></div>
                </li>
            </ul>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            content: string;
            infoBlocks: {
                title: string;
                content: string;
            }[];
            mapFootnote: string;
            advantTitle: string;
            advantSubtitle: string;
            advantCards: {
                title: string;
                content: string;
            }[];
        }>(),
        {
            title: '',
            content: '',
            infoBlocks: () => [],
            cardFootnote: '',
            advantTitle: '',
            advantsubtitle: '',
            advantCards: () => [],
        }
    );
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .faq-delivery {
        @mixin text-content() {
            display: flex;
            flex-direction: column;
            gap: rem(8);
            line-height: 1.3;
            h2,
            h3,
            h4,
            h5,
            h6 {
                font-size: lineScale(24, 18, 480, 1440);
                margin-bottom: rem(16);
            }
            ul,
            ol {
                display: flex;
                flex-direction: column;
                gap: rem(8);
                li {
                    margin-left: rem(22);
                }
            }
            ul > li {
                list-style: disc outside;
            }
            ol > li {
                list-style: decimal outside;
            }
        }

        &__title {
            font-size: lineScale(48, 24, 480, 1440);
            font-weight: $fw-semi;
        }
        &__desc {
            max-width: 70ch;
            font-size: lineScale(18, 16, 480, 1440);
            opacity: 0.8;
            @include text-content();
        }
        &__subtitle {
            font-size: lineScale(32, 20, 480, 1440);
        }
        &__hint {
            max-width: 70ch;
            font-size: lineScale(18, 16, 480, 1440);
            line-height: 1.4;
            font-weight: $fw-bold;
            a {
                color: $c-accent;
                text-decoration: underline;
                @media (pointer: fine) {
                    &:hover {
                        text-decoration: none;
                    }
                }
            }
        }
        &__info {
            display: flex;
            flex-wrap: wrap;
            gap: rem(48) rem(16);
            &-item {
                flex: 1 1 30%;
                min-width: rem(260);
            }
            &-title {
                font-size: lineScale(24, 18, 480, 1440);
                margin-bottom: rem(16);
            }
            &-content {
                text-wrap: balance;
                @include text-content;
                > p,
                ul,
                ol {
                    opacity: 0.8;
                }
            }
        }
        &__address {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            &-validator {
                display: grid;
                grid-template-columns: auto minmax(25%, max-content);
                grid-template-areas:
                    'input button'
                    'result result';
                gap: rem(24) rem(8);
                &-input {
                    $py: rem(18);
                    $px: rem(24);

                    grid-area: input;
                    width: 100%;
                    &:has(input:focus) {
                        > input {
                            border-color: $c-accent !important;
                            background-color: transparent;
                        }
                        > label {
                            background: $c-main !important;
                            opacity: 1;
                        }
                    }
                    @media (pointer: fine) {
                        &:hover {
                            > input {
                                border-color: $c-accent !important;
                            }
                        }
                    }
                    > input {
                        width: 100%;
                        height: 100%;
                        padding: $py $px;
                        border-radius: rem(32);
                        background-color: rgba($c-D4E1E7, 0.25);
                        border: rem(1) solid transparent;
                    }
                    > label {
                        display: block;
                        z-index: 5;
                        left: $px !important;
                        transition-duration: $td !important;
                        padding: 0 rem(4) !important;
                        opacity: 0.5;
                    }
                }
                &-button {
                    grid-area: button;
                    background-color: $c-E5F2D8;
                    @include button-primary(
                        $font-size: lineScale(18, 16, 480, 1440),
                        $border-color: transparent,
                        $anim-color: $c-98BBD7,
                        $padding: rem(18) rem(64)
                    );
                    @media (pointer: fine) {
                        &:hover {
                            background-color: transparent;
                        }
                    }
                }
                &-result {
                    grid-area: result;
                    color: $c-accent;
                }
            }
            //temp
            &-image {
                width: 100%;
                aspect-ratio: 2/1;
                border-radius: rem(32);
                overflow: hidden;
                img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }
            //
        }
        &__advant {
            display: flex;
            flex-direction: column;
            gap: rem(32);
            &-list {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(rem(320), 1fr));
                gap: rem(16);
            }
            &-item {
                display: flex;
                flex-direction: column;
                gap: rem(32);
                color: $c-FFFFFF;
                aspect-ratio: 1.2/1;
                background-color: $c-accent;
                border-radius: rem(16);
                padding: rem(16);
                @include text-content();
            }
        }
    }

    @media (max-width: 768px) {
        .faq-delivery {
            &__advant {
                &-item {
                    aspect-ratio: initial;
                }
            }
            &__address {
                &-validator {
                    display: flex;
                    flex-direction: column;
                    &-button {
                        align-self: flex-end;
                    }
                }
            }
        }
    }

    @media (max-width: 480px) {
        .faq-delivery {
            &__address {
                &-validator {
                    &-button {
                        width: 100%;
                        align-items: center;
                        justify-content: center;
                    }
                }
            }
        }
    }
</style>
