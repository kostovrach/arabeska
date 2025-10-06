<template>
    <div
        class="embla__slide"
        :style="{
            flex: `0 0 ${props.width}`,
            marginRight: `${props.spaceBetween}px`,
        }"
    >
        <slot></slot>
    </div>
</template>

<script setup lang="ts">
    interface Props {
        width?: string;
        spaceBetween?: number;
        padding?: string;
    }

    const props = withDefaults(defineProps<Props>(), {
        width: 'fit-content',
        spaceBetween: 32,
        padding: '0',
    });
</script>

<style scoped lang="scss">
    .embla__slide {
        min-width: 0;
    }
</style>
