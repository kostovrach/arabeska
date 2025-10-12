<template>
    <div class="dropdown">
        <button class="dropdown__button">
            <SvgSprite type="frame" :size="12" />
            <span>Каталог</span>
        </button>
        <div class="dropdown__body"></div>
    </div>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .dropdown {
        &__button {
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: rem(8);
            color: $c-D4E1E7;
            @include frame-scale;
        }
    }
</style>
