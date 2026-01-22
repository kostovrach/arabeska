<template>
    <div class="circular-text">
        <svg class="circular-text__svg" viewBox="0 0 300 80" xmlns="http://www.w3.org/2000/svg">
            <path id="title-arc" d="M 30 65 A 200 200 0 0 1 270 65" fill="none" />

            <text text-anchor="middle" class="circular-text__text">
                <textPath href="#title-arc" startOffset="50%">
                    {{ text }}
                </textPath>
            </text>
        </svg>
    </div>
</template>

<script setup lang="ts">
    defineProps<{
        text: string;
    }>();
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .circular-text {
        position: relative;
        &__svg {
            width: 100%;
            height: auto;
            display: block;
        }
        &__text {
            fill: currentColor;
        }
    }
</style>
