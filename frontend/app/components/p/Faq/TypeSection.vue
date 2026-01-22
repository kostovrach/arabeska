<template>
    <section class="faq-section">
        <h2 class="faq-section__title">{{ props.title }}</h2>
        <div class="faq-section__content" v-html="props.content"></div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            content: string;
        }>(),
        {
            title: '',
            content: '',
        }
    );
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .faq-section {
        @mixin text-content() {
            display: flex;
            flex-direction: column;
            gap: rem(16);
            line-height: 1.6;
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
        &__content {
            max-width: 80ch;
            @include text-content();
        }
    }
</style>
