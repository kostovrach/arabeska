<template>
    <form class="subscribe-form">
        <h3 class="subscribe-form__title" v-html="props.title"></h3>
        <div class="subscribe-form__inputbox">
            <InputMask
                v-model="form.input"
                mask="+7 (999) 999-99-99"
                placeholder="+7 (___) ___-__-__"
                id="subscribe-phone"
                type="text"
                name="subscribe-phone"
            />
        </div>
        <button class="subscribe-form__button" type="submit">
            <span>Подписаться</span>
            <span><SvgSprite type="arrow" :size="24" /></span>
        </button>
        <div class="subscribe-form__agreement">
            <div class="subscribe-form__checkbox">
                <input
                    v-model="form.checkbox"
                    type="checkbox"
                    name="subscribe-agreement"
                    id="subscribe-agreement"
                />
            </div>
            <label for="subscribe-agreement">
                Согласен с политикой конфиденциальности и обработки персональных данных
            </label>
        </div>
    </form>
</template>

<script setup lang="ts">
    const props = defineProps<{
        title: string;
    }>();

    const form = reactive({
        input: '',
        checkbox: true,
    });
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .subscribe-form {
        display: grid;
        grid-template-areas:
            'title title'
            'input button'
            'agreement agreement';
        align-items: center;
        gap: lineScale(32, 16, 480, 1440) lineScale(16, 8, 480, 1440);
        margin-top: rem(32);
        &__title {
            grid-area: title;
            font-family: 'Inter', sans-serif;
            font-size: lineScale(24, 20, 480, 1440);
        }
        &__inputbox {
            grid-area: input;
            height: fit-content;
            position: relative;
            border-bottom: rem(1) solid currentColor;
            opacity: 0.25;
            transition: all $td $tf;
            &::before {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 0;
                height: rem(1.5);
                background-color: currentColor;
                transition: width $td $tf;
            }
            @media (pointer: fine) {
                &:hover {
                    opacity: 0.75;
                    &::before {
                        width: 100%;
                    }
                }
            }
            &:has(input:focus),
            &:not(:has(input:placeholder-shown)) {
                opacity: 1;
                &::before {
                    width: 100%;
                }
            }
            > input {
                width: 100%;
                min-width: 15ch;
                color: inherit;
                background-color: transparent;
                font-family: 'Inter', sans-serif;
                font-size: lineScale(24, 20, 480, 1440);
                padding: rem(12) 0;
            }
        }
        &__button {
            grid-area: button;
            @include button-primary(
                $padding: rem(12) rem(24),
                $gap: rem(8),
                $font-size: lineScale(18, 14, 480, 1440),
                $anim-color: $c-98BBD7
            );
        }
        &__agreement {
            grid-area: agreement;
            display: flex;
            align-items: center;
            gap: rem(8);
            label {
                color: $c-98BBD7;
                font-size: rem(14);
                line-height: 1.2;
                text-wrap: balance;
                opacity: 0.5;
            }
        }
        &__checkbox {
            @include checkbox;
        }
    }

    @media (max-width: 480px) {
        .subscribe-form {
            grid-template-areas:
                'title title'
                'input input'
                'button button'
                'agreement agreement';
            &__button {
                width: 100%;
                justify-content: space-between;
            }
        }
    }
</style>
