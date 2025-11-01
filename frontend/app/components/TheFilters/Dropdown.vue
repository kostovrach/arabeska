<template>
    <div class="cf__item cf__item--dropdown" role="group" :aria-label="`Фильтр по ${label}`">
        <div class="cf__label">{{ label }}</div>
        <div class="cf__options" role="list" aria-live="polite" v-if="items.length">
            <label v-for="item in items" :key="item.id" class="cf-option" role="listitem">
                <input type="checkbox" v-model="selected" :value="item.name" />
                <span>{{ item.name }}</span>
            </label>
        </div>
    </div>
</template>

<script setup lang="ts">
    defineProps<{
        label: string;
        items: { id: number | string; name: string }[];
    }>();
    const selected = defineModel<string[]>('selected', { required: true });
</script>
