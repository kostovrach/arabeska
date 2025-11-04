<template>
    <section id="about" class="franchise-about">
        <div class="franchise-about__container">
            <div class="franchise-about__titlebox">
                <h2 class="franchise-about__title">{{ props.title }}</h2>
                <p class="franchise-about__desc" v-if="props.description">
                    {{ props.description }}
                </p>
            </div>
            <ul class="franchise-about__body" v-if="props.metrics.length">
                <li class="franchise-about__item" v-for="(item, idx) in props.metrics" :key="idx">
                    <span class="franchise-about__item-value">{{ item.value }}</span>
                    <p class="franchise-about__item-desc">{{ item.label }}</p>
                </li>
            </ul>
        </div>
    </section>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            title: string;
            description?: string;
            metrics: {
                value: string;
                label: string;
            }[];
        }>(),
        {
            title: '',
            description: '',
            metrics: () => [],
        }
    );
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .franchise-about {
        scroll-margin: rem(128);
        padding: rem(64) 0;
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: rem(40);
            text-align: center;
        }
        &__title {
            max-width: 30ch;
            font-size: lineScale(48, 32, 480, 1440);
            font-weight: $fw-semi;
        }
        &__desc {
            max-width: 50ch;
            font-family: 'Inter', sans-serif;
            font-size: lineScale(22, 18, 480, 1440);
            line-height: 1.3;
        }
        &__body {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: rem(64) rem(32);
            margin-top: rem(64);
        }
        &__item {
            flex: 1 1 30%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: rem(8);
            text-align: center;
            &-value {
                font-family: 'Inter', sans-serif;
                color: $c-accent;
                font-size: lineScale(128, 96, 480, 1440);
                font-weight: $fw-black;
            }
            &-desc {
                text-transform: lowercase;
                font-size: lineScale(24, 18, 480, 1440);
                font-weight: $fw-semi;
            }
        }
    }
</style>
