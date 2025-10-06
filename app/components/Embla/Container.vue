<template>
    <div class="embla" ref="emblaRef">
        <div class="embla__container" :style="{ padding: props.padding }">
            <slot></slot>
        </div>
    </div>
</template>

<script setup lang="ts">
    import emblaCarouselVue from 'embla-carousel-vue';
    import Autoplay from 'embla-carousel-autoplay';
    import type { AutoplayOptionsType } from 'embla-carousel-autoplay';
    import type { EmblaOptionsType, EmblaPluginType } from 'embla-carousel';

    interface IProps {
        options?: EmblaOptionsType;
        padding?: string;
        autoplayEnable?: boolean;
        autoplay?: AutoplayOptionsType;
    }

    const props = withDefaults(defineProps<IProps>(), {
        options: () => ({}),
        padding: '0',
        autoplayEnable: false,
    });

    const plugins: EmblaPluginType[] = [];
    const [emblaRef, emblaApi] = emblaCarouselVue(props.options);

    if (props.autoplayEnable && props.autoplay) {
        plugins.push(Autoplay(props.autoplay));
    }

    // Expose API для родительских компонентов
    defineExpose({
        emblaApi,
    });
</script>

<style scoped lang="scss">
    .embla {
        overflow: hidden;
        user-select: none;
        &__container {
            display: flex;
        }
    }
</style>
