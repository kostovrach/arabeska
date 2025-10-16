<template>
    <NuxtLayout>
        <WholesaleHero />
        <div class="wholesale">
            <WholesaleList />
            <WholesaleFaq />
            <Banner
                class="wholesale-banner"
                title="Начните работать с нами!"
                image-url="/img/temp/flowers.gif"
            >
                <div class="wholesale-banner__content">
                    <p class="wholesale-banner__text">
                        Наши официальные оптовики получают неоспоримые преимущества партнёрства:
                        доступ к многоуровневой партнёрской программе, скидки на продукцию, подарки
                        и многое другое
                    </p>
                    <button class="wholesale-banner__button" type="button">
                        <span>Подать заявку</span>
                        <span><SvgSprite type="arrow" :size="24" /></span>
                    </button>
                </div>
            </Banner>
        </div>
    </NuxtLayout>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .wholesale {
        background-color: $c-main;
    }
    .wholesale-banner {
        &__content {
            display: flex;
            flex-direction: column;
            gap: rem(32);
        }
        &__text {
            line-height: 1.2;
        }
        &__button {
            @include button-primary($anim-color: $c-accent);
        }
    }
</style>
