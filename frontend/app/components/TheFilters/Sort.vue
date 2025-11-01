<template>
    <div
        class="filters__sort"
        role="combobox"
        :aria-expanded="isOpen"
        :aria-owns="listboxId"
        :aria-label="props.label"
        :aria-activedescendant="ariaActivedescendant"
        tabindex="0"
        @keydown="handleKeydown"
        @mouseleave="closeDropdown"
        @blur="closeDropdown"
    >
        <button
            :class="['filters__sort-button', { open: isOpen }]"
            :aria-controls="listboxId"
            :aria-expanded="isOpen"
            @click="toggleDropdown"
        >
            {{ selectedLabel || 'По умолчанию' }}
            <span class="filters__sort-button-icon">
                <SvgSprite type="chevron" :size="16" />
            </span>
        </button>
        <ul v-if="isOpen" class="filters__sort-list" role="listbox" :id="listboxId" tabindex="-1">
            <li
                v-for="(option, idx) in props.options"
                :key="option.value"
                role="option"
                :aria-selected="value === option.value"
                :id="`${listboxId}-option-${idx}`"
                :class="[
                    'filters__sort-option',
                    { selected: value === option.value || activeIndex === idx },
                ]"
                @click="selectOption(option.value)"
                @mouseenter="activeIndex = idx"
            >
                {{ option.label }}
            </li>
        </ul>
    </div>
</template>

<script setup lang="ts">
    const props = withDefaults(
        defineProps<{
            label: string;
            options: { value: string; label: string }[];
        }>(),
        {
            label: '',
            options: () => [],
        }
    );

    // state ===================================================================================
    const emit = defineEmits<{ (e: 'update:modelValue', value: string | null): void }>();

    const value = defineModel<string | null>('modelValue', { default: '' });

    const isOpen = ref(false);
    const activeIndex = ref(-1);
    const listboxId = ref(`listbox-${Math.random().toString(36).slice(2)}`);

    const selectedLabel = computed(
        () => props.options.find((opt) => opt.value === value.value)?.label || ''
    );

    const ariaActivedescendant = computed(() =>
        isOpen.value && activeIndex.value !== -1
            ? `${listboxId.value}-option-${activeIndex.value}`
            : undefined
    );
    // =========================================================================================

    // handlers ================================================================================
    function toggleDropdown() {
        isOpen.value = !isOpen.value;
        if (isOpen.value)
            activeIndex.value = props.options.findIndex((opt) => opt.value === value.value);
    }

    function closeDropdown() {
        isOpen.value = false;
        activeIndex.value = -1;
    }

    function selectOption(val: string) {
        value.value = val;
        emit('update:modelValue', val);
        closeDropdown();
    }

    function handleKeydown(event: KeyboardEvent) {
        if (
            !isOpen.value &&
            (event.key === 'Enter' || event.key === ' ' || event.key === 'ArrowDown')
        ) {
            event.preventDefault();
            toggleDropdown();
            return;
        }

        if (isOpen.value) {
            switch (event.key) {
                case 'ArrowDown':
                    event.preventDefault();
                    activeIndex.value = (activeIndex.value + 1) % props.options.length;
                    break;
                case 'ArrowUp':
                    event.preventDefault();
                    activeIndex.value =
                        (activeIndex.value - 1 + props.options.length) % props.options.length;
                    break;
                case 'Enter':
                case ' ':
                    event.preventDefault();
                    if (activeIndex.value !== -1)
                        selectOption(props.options[activeIndex.value]?.value ?? '');
                    break;
                case 'Escape':
                case 'Tab':
                    closeDropdown();
                    break;
            }
        }
    }

    // =========================================================================================
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .filters__sort {
        $p: &;

        position: relative;
        width: 100%;
        max-width: rem(320);
        &-button {
            cursor: pointer;
            box-sizing: border-box;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: rem(64);
            padding: rem(18) rem(24);
            border: rem(1) solid $c-D4E1E7;
            border-radius: rem(32);
            background-color: rgba($c-D4E1E7, 0.15);
            &-icon {
                transition: transform calc($td / 2) $tf;
            }
            &.open {
                border-radius: rem(32) rem(32) 0 0;
                #{$p}-button-icon {
                    transform: scaleY(-1);
                }
            }
        }
        &-list {
            position: absolute;
            z-index: 5;
            top: 100%;
            left: 0;
            right: 0;
            background-color: $c-FFFFFF;
            border: rem(1) solid $c-D4E1E7;
            border-top: none;
            border-radius: 0 0 rem(32) rem(32);
            box-shadow: 1px 1px 5px $c-D4E1E7;
            overflow: hidden;
        }
        &-option {
            cursor: pointer;
            padding: rem(12) rem(24);
            &.selected {
                background-color: rgba($c-D4E1E7, 0.15);
            }
            @media (pointer: fine) {
                &:hover {
                    background-color: rgba($c-D4E1E7, 0.15);
                }
            }
        }
    }
</style>
