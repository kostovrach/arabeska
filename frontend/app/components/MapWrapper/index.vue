<template>
    <ClientOnly>
        <YandexMap
            class="map"
            :settings="{
                location: {
                    center: [50.18, 53.22],
                    zoom: 12,
                },
            }"
        >
            <YandexMapDefaultSchemeLayer />
            <YandexMapDefaultFeaturesLayer />
            <YandexMapUiMarker
                :settings="{ coordinates: [50.17642, 53.20713], title: 'Arabeska', color: 'green' }"
            />
            <YandexMapUiMarker
                :settings="{
                    coordinates: [50.09415, 53.19515],
                    popup: { content: 'sdvsdvsd' },
                    title: 'Arabeska',
                    color: 'green',
                }"
            />
            <YandexMapUiMarker
                :settings="{ coordinates: [50.25308, 53.24717], title: 'Arabeska', color: 'green' }"
            />
        </YandexMap>
    </ClientOnly>
</template>

<script setup lang="ts">
    import {
        YandexMap,
        YandexMapDefaultSchemeLayer,
        YandexMapDefaultFeaturesLayer,
        YandexMapDefaultMarker,
        YandexMapUiMarker,
    } from 'vue-yandex-maps';
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .map {
        font-family: 'Inter', sans-serif;
    }
</style>
