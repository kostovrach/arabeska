<!-- components/SortDropdown.vue -->
<template>
    <div
        class="cf__item cf__item--sort custom-select"
        role="combobox"
        :aria-expanded="isOpen"
        :aria-owns="listboxId"
        :aria-label="label"
        tabindex="0"
        @keydown="handleKeydown"
        @click="toggleDropdown"
        @blur="closeDropdown"
    >
        <button class="custom-select__trigger" :aria-controls="listboxId" :aria-expanded="isOpen">
            <span>{{ selectedLabel || 'По умолчанию' }}</span>
            <span class="arrow" :class="{ 'arrow--up': isOpen }">&#9660;</span>
            <!-- Стрелка -->
        </button>
        <ul
            v-if="isOpen"
            class="custom-select__options"
            role="listbox"
            :id="listboxId"
            tabindex="-1"
        >
            <li
                v-for="(option, index) in options"
                :key="option.value"
                role="option"
                :aria-selected="value === option.value"
                :id="`${listboxId}-option-${index}`"
                :class="{ selected: value === option.value }"
                @click="selectOption(option.value)"
                @mouseenter="activeIndex = index"
            >
                {{ option.label }}
            </li>
        </ul>
    </div>
</template>

<script setup lang="ts">
    const props = defineProps<{
        label: string;
        options: { value: string; label: string }[];
    }>();

    const emit = defineEmits<{ (e: 'update:modelValue', value: string | null): void }>();

    const value = defineModel<string | null>('modelValue', { default: '' });

    const isOpen = ref(false);
    const activeIndex = ref(-1);
    const listboxId = ref(`listbox-${Math.random().toString(36).slice(2)}`);

    const selectedLabel = computed(
        () => props.options.find((opt) => opt.value === value.value)?.label || ''
    );

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

    // ARIA activedescendant update
    const ariaActivedescendant = computed(() =>
        isOpen.value && activeIndex.value !== -1
            ? `${listboxId.value}-option-${activeIndex.value}`
            : undefined
    );

    // Добавьте в div: :aria-activedescendant="ariaActivedescendant"
    onMounted(() => {
        // Для фокуса
    });
</script>

<style lang="scss" scoped>
    .custom-select {
        position: relative;
        min-width: 180px;
    }

    .custom-select__trigger {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0.45rem 0.6rem;
        border: 1px solid #ddd;
        border-radius: 6px;
        background: #fff;
        cursor: pointer;
        width: 100%;
    }

    .arrow {
        transition: transform 0.2s;
    }

    .arrow--up {
        transform: rotate(180deg);
    }

    .custom-select__options {
        position: absolute;
        top: 100%;
        left: 0;
        right: 0;
        background: #fff;
        border: 1px solid #ddd;
        border-radius: 6px;
        max-height: 200px;
        overflow-y: auto;
        z-index: 10;
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .custom-select__options li {
        padding: 0.5rem 1rem;
        cursor: pointer;
        &:hover,
        &.selected {
            background: #f0f0f0;
        }
    }
</style>
