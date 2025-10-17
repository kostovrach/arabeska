<template>
    <section :class="['faq-section', props.vertical ? 'faq-section--vertical' : '']">
        <div class="faq-section__container">
            <div class="faq-section__titlebox">
                <h3 class="faq-section__title">{{ props.title }}</h3>
                <p class="faq-section__desc" v-html="props.description"></p>
            </div>
            <div class="faq-section__body">
                <Accordion class="faq-section__list" multiple>
                    <template #expandicon>
                        <span class="faq-section__item-icon faq-section__item-icon--expand"></span>
                    </template>
                    <template #collapseicon>
                        <span
                            class="faq-section__item-icon faq-section__item-icon--collapse"
                        ></span>
                    </template>
                    <AccordionPanel
                        v-for="(item, idx) in props.content"
                        :key="idx"
                        class="faq-section__item"
                        :value="idx"
                    >
                        <AccordionHeader>
                            <h4 class="faq-section__item-title">{{ item.title }}</h4>
                        </AccordionHeader>
                        <AccordionContent>
                            <div class="faq-section__item-content" v-html="item.body"></div>
                        </AccordionContent>
                    </AccordionPanel>
                </Accordion>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { IFaqItem } from '~/interfaces/faq-item';

    const props = defineProps<{
        vertical?: boolean;
        title: string;
        description?: string;
        content: IFaqItem[];
    }>();
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .faq-section {
        $p: &;

        padding: rem(64) 0;
        &--vertical {
            #{$p}__container {
                display: flex;
                flex-direction: column;
                padding: 0;
                margin: 0;
            }
            #{$p}__titlebox,
            #{$p}__body {
                padding: 0;
            }
        }
        &__container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: rem(48);
            @include content-container;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            gap: rem(16);
        }
        &__title {
            font-size: lineScale(32, 24, 480, 1440);
        }
        &__desc {
            max-width: 50ch;
            font-family: 'Inter', sans-serif;
            font-size: lineScale(18, 16, 480, 1440);
            line-height: 1.3;
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
        &__titlebox,
        &__body {
            padding: rem(32);
        }
        &__list {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            * {
                border-style: hidden !important;
            }
        }
        &__item {
            font-family: 'Inter', sans-serif;
            box-shadow: 0 3px 5px rgba($c-secondary, 0.2);
            border-radius: rem(16);
            &-icon {
                display: block;
                min-width: rem(8);
                max-width: rem(8);
                aspect-ratio: 1;
                margin-right: rem(16);
                &--expand {
                    background-color: currentColor;
                    border-radius: 50%;
                }
                &--collapse {
                    background-color: $c-accent;
                    border-radius: 0;
                }
            }
            &-title {
                font-size: rem(18);
                font-weight: $fw-semi;
                padding: rem(16) rem(32);
            }
            &-content {
                display: flex;
                flex-direction: column;
                gap: rem(16);
                font-size: lineScale(18, 16, 480, 1440);
                line-height: 1.3;
                padding: rem(16) rem(32);
                h2,
                h3,
                h4,
                h5,
                h6 {
                    font-size: lineScale(32, 24, 480, 1440);
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
        }
    }

    @media (max-width: 1024px) {
        .faq-section {
            &__container {
                display: flex;
                flex-direction: column;
            }
            &__titlebox,
            &__body {
                padding: 0;
            }
        }
    }
</style>
