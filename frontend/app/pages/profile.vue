<template>
    <NuxtLayout>
        <div class="profile">
            <div class="profile__container">
                <div class="profile__titlebox">
                    <h1 class="profile__title">Личный кабинет</h1>
                    <div class="profile__controls">
                        <p class="profile__phone">
                            {{ partialHiddenPhone(decoratePhone(user.phone)) }}
                        </p>
                        <button class="profile__loout" type="button">
                            <span>Выйти</span>
                            <span><SvgSprite type="arrow" :size="16" /></span>
                        </button>
                    </div>
                </div>

                <div class="profile__body">
                    <aside class="profile__nav">
                        <div class="profile__nav-container">
                            <a class="profile__nav-link" href="#"></a>
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

    const userStore = useUserStore();

    const user = userStore.user!;
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .profile {
        &__phone {
            font-family: 'Inter', sans-serif;
        }
    }
</style>
