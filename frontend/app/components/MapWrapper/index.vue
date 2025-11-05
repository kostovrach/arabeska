<template>
    <ClientOnly>
        <YandexMap
            class="map"
            @click="markersIdx = null"
            @mouseleave="markersIdx = null"
            :settings="{
                location: {
                    center: [50.18, 53.22],
                    zoom: 12,
                },
            }"
        >
            <YandexMapDefaultSchemeLayer />
            <YandexMapDefaultFeaturesLayer />
            <YandexMapControls :settings="{ position: 'right' }">
                <YandexMapZoomControl />
                <YandexMapGeolocationControl />
            </YandexMapControls>
            <YandexMapControls :settings="{ position: 'left top' }">
                <YandexMapOpenMapsButton />
            </YandexMapControls>
            <YandexMapUiMarker
                v-for="(marker, idx) in markers"
                :key="idx"
                :settings="{
                    onClick: () => (markersIdx === idx ? (markersIdx = null) : (markersIdx = idx)),
                    coordinates: marker.coordinates as LngLat,
                    title: marker.title,
                    color: 'green',
                    popup: { show: markersIdx === idx, position: 'bottom right', offset: 10 },
                }"
            >
                <template #popup>
                    <div class="map__marker">
                        <div class="map__marker-head" v-if="marker.content.head">
                            {{ marker.content.head }}
                        </div>
                        <div
                            class="map__marker-body"
                            v-if="marker.content.body"
                            v-html="marker.content.body"
                        ></div>
                        <div class="map__marker-footer" v-if="marker.content.footer">
                            {{ marker.content.footer }}
                        </div>
                    </div>
                </template>
            </YandexMapUiMarker>
            <YandexMapSignpost
                :settings="{ points: markers.map((el) => el.coordinates) as LngLat[] }"
            />
        </YandexMap>
    </ClientOnly>
</template>

<script setup lang="ts">
    import type { LngLat } from '@yandex/ymaps3-types';

    import {
        YandexMap,
        YandexMapDefaultSchemeLayer,
        YandexMapDefaultFeaturesLayer,
        YandexMapUiMarker,
        YandexMapControls,
        YandexMapZoomControl,
        YandexMapSignpost,
        YandexMapGeolocationControl,
        YandexMapOpenMapsButton,
    } from 'vue-yandex-maps';

    // state
    const markersIdx = ref<number | null>(null);

    // data
    const markers = [
        {
            coordinates: [50.17642, 53.20713],
            title: 'Arabeska',
            content: {
                head: 'ул. Революционная 101 Б',
                body: 'Телефон: <a href="tel:+7(846)202-03-33">+7 (846) 202-03-33</a>',
                footer: 'Ежедневно с 8.00 до 20.00',
            },
        },
        {
            coordinates: [50.09415, 53.19515],
            title: 'Arabeska',
            content: {
                head: 'ул. Куйбышева, 147',
                body: 'Телефон: <a href="tel:+7(987)430-86-79">+7 (987) 430-86-79</a>',
                footer: 'Ежедневно с 8.00 до 20.00',
            },
        },
        {
            coordinates: [50.25308, 53.24717],
            title: 'Arabeska',
            content: {
                head: 'ул. Ташкентская, 99',
                body: 'Телефон: <a href="tel:+7(917)956-91-65">+7 (987) 430-86-79</a>',
                footer: 'Ежедневно с 8.00 до 20.00',
            },
        },
    ];
</script>

<style lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .map {
        font-family: 'Inter', sans-serif;
        &__marker {
            display: flex;
            flex-direction: column;
            gap: rem(8);
            &-head {
                font-size: rem(16);
                font-weight: $fw-semi;
            }
            &-body {
                > a {
                    cursor: pointer;
                    color: $c-accent;
                    text-decoration: underline;
                    @media (pointer: fine) {
                        &:hover {
                            text-decoration: none;
                        }
                    }
                }
            }
            &-footer {
                font-size: rem(12);
                font-weight: $fw-semi;
                opacity: 0.5;
            }
        }
    }
</style>
