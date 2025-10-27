<template>
    <section class="home-map">
        <div class="home-map__container">
            <div class="home-map__content">
                <div class="home-map__titlebox">
                    <h2 class="home-map__title">Свежие цветы рядом с вашим домом</h2>
                    <SvgSprite type="star" size="100%" />
                    <SvgSprite type="star" size="100%" />
                </div>
                <div class="home-map__list">
                    <a href="https://example.com" target="_blank" rel="noopener noreferrer">
                        <span>Самара, Проспект Кирова, 22 (БЦ Бигбен)</span>
                        <SvgSprite type="arrow" :size="16" />
                    </a>
                    <a href="https://example.com" target="_blank" rel="noopener noreferrer">
                        <span>Самара, Улица Ленина, 15, ТЦ «Аврора», офис 21</span>
                        <SvgSprite type="arrow" :size="16" />
                    </a>
                    <a href="https://example.com" target="_blank" rel="noopener noreferrer">
                        <span>Самара, Площадь Славы, 5</span>
                        <SvgSprite type="arrow" :size="16" />
                    </a>
                </div>
            </div>
            <div class="home-map__map">
                <img src="/img/temp/map.jpg" alt="#" />
            </div>
        </div>
    </section>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .home-map {
        @include content-block;
        &__container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            align-items: center;
            justify-content: space-between;
            gap: rem(64);
            @include content-container;
        }
        &__content {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: rem(40);
        }
        &__titlebox {
            position: relative;
            width: fit-content;
            color: $c-D4E1E7;
            > svg {
                position: absolute;
                &:nth-of-type(1) {
                    width: rem(64);
                    top: -70%;
                    right: 10%;
                }
                &:nth-of-type(2) {
                    width: rem(34);
                    top: -90%;
                    right: 5%;
                }
            }
        }
        &__title {
            font-size: lineScale(64, 24, 480, 1440);
            font-weight: $fw-semi;
            color: $c-secondary;
        }
        &__list {
            display: flex;
            flex-direction: column;
            gap: rem(18);
            > a {
                width: fit-content;
                display: flex;
                align-items: center;
                gap: rem(8);
                font-family: 'Inter', sans-serif;
                font-size: lineScale(20, 18, 480, 1440);
                font-weight: $fw-semi;
                @include hover-blick-line();
                > svg {
                    rotate: -45deg;
                }
            }
        }
        &__map {
            width: 100%;
            height: rem(512);
            border-radius: rem(32);
            overflow: hidden;
            // temp==========================
            img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            // ==============================
        }
    }

    @media (max-width: 1024px) {
        .home-map {
            &__container {
                display: flex;
                flex-direction: column;
            }
            &__map {
                height: rem(320);
            }
        }
    }
</style>
