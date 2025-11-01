<template>
    <div
        v-if="props.items.length"
        class="filters__item"
        role="group"
        :aria-expanded="isOpen"
        :aria-label="`Фильтр по ${props.label}`"
        @mouseleave="closeDropdown"
    >
        <button
            class="filters__item-button"
            tabindex="0"
            @click="toggleDropdown"
            @keydown="handleKeydown"
        >
            <div class="filters__item-button-label">
                {{ props.label }}
                <span v-if="selected.length">{{ selected.length }}</span>
            </div>
            <div :class="['filters__item-button-icon', { open: isOpen }]">
                <SvgSprite type="chevron" :size="14" />
            </div>
        </button>
        <div
            v-if="isOpen"
            class="filters__item-list"
            role="list"
            aria-live="polite"
            :aria-expanded="isOpen"
        >
            <label
                v-for="(item, idx) in orderedItems"
                :key="idx"
                class="filters__item-option"
                role="listitem"
                :for="`filter-${slugify(props.label)}-${idx + 1}`"
            >
                <input
                    :id="`filter-${slugify(props.label)}-${idx + 1}`"
                    type="checkbox"
                    v-model="selected"
                    :value="item.name"
                />
                <span>{{ item.name }}</span>
            </label>
        </div>
    </div>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            label: string;
            items: { id: number | string; name: string }[];
        }>(),
        {
            label: '-',
            items: () => [],
        }
    );

    const selected = defineModel<string[]>('selected', { required: true });
    const isOpen = ref(false);

    const orderedItems = computed(() => {
        const selectedSet = new Set(selected.value);
        return [
            ...props.items.filter((item) => selectedSet.has(item.name)),
            ...props.items.filter((item) => !selectedSet.has(item.name)),
        ];
    });

    // handlers ==================================================================
    function toggleDropdown() {
        isOpen.value = !isOpen.value;
    }
    function closeDropdown() {
        isOpen.value = false;
    }
    function handleKeydown(event: KeyboardEvent) {
        if (isOpen.value && (event.key === 'Escape' || event.key === 'Tab')) {
            closeDropdown();
        } else return;
    }
    // ===========================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .filters__item {
        position: relative;
        &-button {
            width: fit-content;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: rem(16);
            padding: rem(12) rem(18);
            border-radius: rem(32);
            opacity: 0.8;
            &:focus {
                opacity: 1;
                background-color: $c-D4E1E7;
            }
            &:active {
                scale: 0.98;
            }
            @media (pointer: fine) {
                &:hover {
                    opacity: 1;
                    background-color: $c-D4E1E7;
                }
            }
            &-label {
                position: relative;
                > span {
                    font-family: monospace;
                    width: rem(18);
                    aspect-ratio: 1;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: rem(12);
                    color: $c-FFFFFF;
                    position: absolute;
                    top: 0;
                    left: 0;
                    translate: -75% -60%;
                    background-color: $c-accent;
                    border-radius: 50%;
                }
            }
            &-icon {
                transition: transform calc($td / 2) $tf;
                &.open {
                    transform: scaleY(-1);
                }
            }
        }
        &-list {
            position: absolute;
            z-index: 5;
            top: 100%;
            left: 50%;
            translate: -30% 0;
            width: max-content;
            max-width: rem(370);
            display: flex;
            flex-wrap: wrap;
            gap: rem(8);
            padding: rem(16);
            border-radius: rem(32);
            background-color: $c-FFFFFF;
            box-shadow: 1px 1px 5px $c-D4E1E7;
        }
        &-option {
            cursor: pointer;
            font-size: lineScale(16, 14, 480, 1440);
            padding: rem(6) rem(16);
            border: rem(1) solid $c-D4E1E7;
            border-radius: rem(32);
            &:has(input[type='checkbox']:checked) {
                color: $c-FFFFFF;
                background-color: $c-accent;
                border-color: $c-accent;
            }
            &:active {
                scale: 0.98;
            }
            @media (pointer: fine) {
                &:not(:has(input[type='checkbox']:checked)):hover {
                    color: $c-accent;
                    border-color: $c-accent;
                }
            }
        }
    }

    @media (max-width: 580px) {
        .filters__item {
            &-list {
                max-width: rem(280);
            }
        }
    }
</style>
