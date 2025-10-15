<template>
    <div class="page">
        <TheHeader />
        <main class="content">
            <slot></slot>
        </main>
        <TheFooter />
    </div>
</template>

<script setup lang="ts"></script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .page {
        overflow-x: clip;
    }
</style>
