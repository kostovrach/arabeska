<template>
    <NuxtLayout>
        <div class="profile" v-if="user">
            <div class="profile__container">
                <div class="profile__titlebox">
                    <h1 class="profile__title">Личный кабинет</h1>
                    <div class="profile__controls">
                        <p class="profile__controls-phone">
                            {{ partialHiddenPhone(decoratePhone(user.phone)) }}
                        </p>
                        <button class="profile__controls-logout" type="button" @click="logout">
                            <span>Выйти</span>
                            <span>
                                <SvgSprite type="arrow" :size="12" style="rotate: -45deg" />
                            </span>
                        </button>
                    </div>
                </div>

                <div class="profile__body">
                    <aside class="profile__nav">
                        <div class="profile__nav-container">
                            <a class="profile__nav-link" href="#"><span>Информация</span></a>
                            <a class="profile__nav-link" href="#"><span>Заказы</span></a>
                            <a class="profile__nav-link" href="#"><span>Адреса</span></a>
                        </div>
                    </aside>
                    <section class="profile__section profile__section--info">
                        <h2 class="profile__section-title">Информация о покупателе</h2>
                        <form class="profile__data">
                            <div class="profile__data-field">
                                <div class="profile__data-field-titlebox">
                                    <span class="profile__data-field-title"></span>
                                </div>
                                <input
                                    id="user-name"
                                    class="profile__data-field-input"
                                    type="text"
                                />
                            </div>
                            <div class="profile__data-field">
                                <div class="profile__data-field-titlebox">
                                    <span class="profile__data-field-title">Имя</span>
                                    <span class="profile__data-field-hint"></span>
                                </div>
                                <InputMask
                                    id="user-phone"
                                    class="profile__data-field-input"
                                    type="number"
                                    mask="+7 (999) 999-99-99"
                                    placeholder="+7 (___) ___-__-__"
                                />
                            </div>
                            <div class="profile__data-field">
                                <div class="profile__data-field-titlebox">
                                    <span class="profile__data-field-title"></span>
                                    <span class="profile__data-field-hint"></span>
                                </div>
                                <input
                                    id="user-email"
                                    class="profile__data-field-input"
                                    type="email"
                                />
                            </div>
                        </form>
                    </section>
                </div>
            </div>
        </div>
    </NuxtLayout>
</template>

<script setup lang="ts">
    definePageMeta({
        middleware: 'auth',
    });

    // data =============================================================
    const userStore = useUserStore();

    const user = userStore.user;
    // ==================================================================

    // methods ==========================================================
    function logout(): void {
        userStore.logout();
        navigateTo('/');
    }
    // ==================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .profile {
        margin: lineScale(64, 32, 480, 1440) 0;
        &__container {
            @include content-container;
        }
        &__titlebox {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
        }
        &__title {
            font-size: lineScale(64, 32, 480, 1920);
            font-weight: $fw-semi;
        }
        &__controls {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: rem(8);
            font-family: 'Inter', sans-serif;
            text-align: right;
            &-phone {
                font-size: lineScale(24, 18, 480, 1920);
                font-weight: $fw-bold;
            }
            &-logout {
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: rem(4);
                font-size: lineScale(16, 14, 480, 1920);
                color: $c-F5142B;
                font-weight: $fw-semi;
                > span:has(svg) {
                    transition: translate $td $tf;
                }
                @media (pointer: fine) {
                    &:hover {
                        > span:has(svg) {
                            translate: rem(2) rem(-2);
                        }
                    }
                }
            }
        }
        &__body {
            display: grid;
            grid-template-columns: auto 70%;
            gap: rem(24);
            margin-top: rem(96);
        }
        &__nav {
            position: relative;
            width: 100%;
            height: 100%;
            &-container {
                position: sticky;
                top: rem(132);
                display: flex;
                flex-direction: column;
                border-radius: rem(32);
                box-shadow: 1px 1px 5px rgba($c-D4E1E7, 0.7);
            }
            &-link {
                font-size: lineScale(22, 18, 480, 1440);
                @include frame-scale($padding: rem(18) rem(32), $border-radius: rem(32));
            }
        }

        &__section {
            padding: lineScale(32, 16, 480, 1920);
            box-shadow: 1px 1px 5px rgba($c-D4E1E7, 0.7);
            border-radius: rem(32);
            &-title {
                font-size: lineScale(32, 24, 480, 1920);
                line-height: 1.2;
                margin-bottom: rem(32);
            }
        }
    }
</style>
