<template>
    <Accordion class="product-spoilers" unstyled :multiple="props.multiple">
        <AccordionPanel
            v-for="(item, idx) in props.spoilers"
            :key="idx"
            :value="idx"
            class="product-spoilers__item"
        >
            <AccordionHeader class="product-spoilers__item-title">{{ item.title }}</AccordionHeader>
            <AccordionContent>
                <div class="product-spoilers__item-content" v-html="item.content"></div>
            </AccordionContent>
        </AccordionPanel>
    </Accordion>
</template>

<script setup lang="ts">
    const props = defineProps<{
        multiple?: boolean;
        spoilers?: {
            title: string;
            content: string;
        }[];
    }>();
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .product-spoilers {
        $p: &;

        display: flex;
        flex-direction: column;
        gap: rem(16);
        border-style: hidden;
        &__item {
            display: flex;
            flex-direction: column;
            font-family: 'Inter', sans-serif;
            border: rem(1) solid $c-D4E1E7;
            border-radius: rem(32);
            &-title {
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: space-between;
                font-size: lineScale(28, 20, 480, 1440);
                font-weight: $fw-semi;
                padding: lineScale(32, 24, 480, 1440);
            }
            &-content {
                display: flex;
                flex-direction: column;
                gap: rem(24);
                line-height: 1.4;
                padding: lineScale(40, 24, 480, 1440);
                padding-top: 0;
                ul,
                ol {
                    display: flex;
                    flex-direction: column;
                    gap: rem(8);
                    > li {
                        margin-left: rem(18);
                    }
                }
                ul > li {
                    list-style: disc outside;
                }
                ol > li {
                    list-style: decimal outside;
                }
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
        }
    }
</style>
