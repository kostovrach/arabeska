<template>
    <NuxtLayout>
        <HomeHero />
        <HomeCarousel
            title="В тренде"
            endpoint="/products"
            :params="{ lazy: true, immediate: true }"
            :wtith-controls="false"
            :wtith-link="false"
            card-variant="large"
        />
        <HomeCarousel
            title="Бестселлеры"
            endpoint="/products"
            :params="{ lazy: true, immediate: true }"
        />
    </NuxtLayout>
</template>

<script setup lang="ts"></script>
