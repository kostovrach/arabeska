<template>
    <footer class="footer">
        <div class="footer__container">
            footer
        </div>
    </footer>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .footer {
        color: $c-FFFFFF;
        padding: rem(64) 0;
        background-color: $c-secondary;
        &__container {
            @include content-container;
        }
    }
</style>
