<template>
    <section id="pricing" class="subscription-pricing">
        <div class="subscription-pricing__container">
            <div class="subscription-pricing__titlebox">
                <h2 class="subscription-pricing__title">{{ props.title }}</h2>
                <p class="subscription-pricing__desc" v-if="props.description">
                    {{ props.description }}
                </p>
            </div>
            <div class="subscription-pricing__list">
                <PSubscriptionPricingCard
                    v-for="(card, idx) in props.pricingCards"
                    :key="card.id"
                    :data="card"
                />
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
    import type { IProduct } from '~~/interfaces/entities/product';

    const props = withDefaults(
        defineProps<{
            title?: string;
            description?: string;
            pricingCards: IProduct[];
        }>(),
        {
            title: 'Тарифы',
            description: '',
            pricingCards: () => [],
        }
    );
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .subscription-pricing {
        $p: &;

        scroll-margin: rem(128);
        @include content-block($margin: rem(64));
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            gap: rem(48);
        }
        &__title {
            font-size: lineScale(48, 24, 480, 1440);
            font-weight: $fw-semi;
        }
        &__desc {
            max-width: 50ch;
            font-size: lineScale(24, 18, 480, 1440);
            line-height: 1.25;
        }
        &__list {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: lineScale(32, 8, 480, 1440);
            margin-top: rem(96);
        }
    }

    @media (max-width: 1100px) {
        .subscription-pricing {
            &__list {
                grid-template-columns: repeat(2, 1fr);
            }
            &__item {
                aspect-ratio: 1.2/1;
            }
        }
    }

    @media (max-width: 768px) {
        .subscription-pricing {
            &__item {
                aspect-ratio: 1/1.2;
            }
        }
    }

    @media (max-width: 540px) {
        .subscription-pricing {
            &__list {
                display: flex;
                flex-direction: column;
            }
            &__item {
                aspect-ratio: 1.1/1;
            }
        }
    }
</style>
