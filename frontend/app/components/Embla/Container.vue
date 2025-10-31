<template>
    <div ref="emblaRef" class="embla" :style="{ overflow: props.overflow }">
        <div class="embla__container" :style="{ padding: props.padding }">
            <slot></slot>
        </div>
    </div>
</template>

<script setup lang="ts">
    import emblaCarouselVue from 'embla-carousel-vue';
    import Autoplay from 'embla-carousel-autoplay';
    import Fade from 'embla-carousel-fade';
    import type { AutoplayOptionsType } from 'embla-carousel-autoplay';
    import type { EmblaOptionsType, EmblaPluginType } from 'embla-carousel';

    interface IProps {
        options?: EmblaOptionsType;
        fade?: boolean;
        padding?: string;
        autoplayEnable?: boolean;
        autoplay?: AutoplayOptionsType;
        overflow?: 'hidden' | 'visible'
    }

    const props = withDefaults(defineProps<IProps>(), {
        options: () => ({}),
        autoplay: () => ({}),
        fade: false,
        padding: '0',
        autoplayEnable: false,
        overflow: 'hidden'
    });

    const plugins: EmblaPluginType[] = [];

    if (props.autoplayEnable && props.autoplay) {
        plugins.push(
            Autoplay({
                ...props.autoplay,
            })
        );
    }

    if (props.fade) {
        plugins.push(Fade());
    }

    const [emblaRef, emblaApi] = emblaCarouselVue(props.options, plugins);

    defineExpose({
        emblaApi,
    });
</script>

<style scoped lang="scss">
    .embla {
        user-select: none;
        &__container {
            display: flex;
            align-items: center;
        }
    }
</style>
