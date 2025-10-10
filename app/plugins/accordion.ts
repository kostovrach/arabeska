import type { DirectiveBinding, ObjectDirective } from 'vue';

interface AccordionOptions {
    hover?: boolean;
    defaultIndex?: number | null;
    activeClass?: string;
}

const accordionDirective: ObjectDirective<HTMLElement, AccordionOptions> = {
    mounted(el, binding: DirectiveBinding<AccordionOptions>) {
        if (import.meta.server) return;

        const options = binding.value || {};
        const { hover = false, defaultIndex = null, activeClass = 'active' } = options;

        const items = Array.from(el.children) as HTMLElement[];

        if (!items.length) return;

        const activate = (index: number) => {
            items.forEach((item) => item.classList.remove(activeClass));
            const target = items[index];
            if (target) target.classList.add(activeClass);
        };

        const listeners: { el: HTMLElement; handlers: (() => void)[] }[] = [];

        items.forEach((item, index) => {
            const handlers: (() => void)[] = [];

            const clickHandler = () => activate(index);
            item.addEventListener('click', clickHandler);
            handlers.push(() => item.removeEventListener('click', clickHandler));

            if (hover) {
                const hoverHandler = () => activate(index);
                item.addEventListener('mouseenter', hoverHandler);
                handlers.push(() => item.removeEventListener('mouseenter', hoverHandler));
            }

            listeners.push({ el: item, handlers });
        });

        if (
            defaultIndex !== null &&
            Number.isInteger(defaultIndex) &&
            defaultIndex >= 0 &&
            defaultIndex < items.length
        ) {
            activate(defaultIndex);
        }

        (el as any).__accordionCleanup__ = () => {
            listeners.forEach(({ handlers }) => handlers.forEach((off) => off()));
        };
    },

    unmounted(el) {
        const cleanup = (el as any).__accordionCleanup__;
        if (typeof cleanup === 'function') cleanup();
        delete (el as any).__accordionCleanup__;
    },
};

export default defineNuxtPlugin((nuxtApp) => {
    nuxtApp.vueApp.directive('accordion', accordionDirective);
});
