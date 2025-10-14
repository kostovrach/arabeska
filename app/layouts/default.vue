<template>
    <TheHeader />
    <main class="page">
        <slot></slot>
    </main>
    <aside class="aside" aria-hidden="true">
        <AsideMenu class="aside__menu" />
    </aside>
    <TheFooter />
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .aside {
        position: fixed;
        z-index: 20;
        inset: 0;
        &::before {
            content: '';
            position: absolute;
            z-index: 1;
            inset: 0;
            backdrop-filter: blur(10px) brightness(50%);
            transition: backdrop-filter $td $tf;
        }
        &__menu {
            position: absolute;
            z-index: 2;
            top: 0;
            right: 0;
        }
    }
</style>
