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
                v-for="(marker, idx) in markers?.addresses"
                :key="idx"
                :settings="{
                    onClick: () => (markersIdx === idx ? (markersIdx = null) : (markersIdx = idx)),
                    coordinates: marker.point.coordinates,
                    title: 'Arabeska',
                    color: 'green',
                    popup: { show: markersIdx === idx, position: 'bottom right', offset: 10 },
                }"
            >
                <template #popup>
                    <div class="map__marker">
                        <div class="map__marker-head">
                            {{ marker.short_address }}
                        </div>
                        <div class="map__marker-body" v-if="marker.phone">
                            Телефон:
                            <a :href="`tel:${marker.phone.trim().split(' ').join('')}`">
                                {{ marker.phone }}
                            </a>
                        </div>
                        <div class="map__marker-footer" v-if="marker.working_hours">
                            {{ marker.working_hours }}
                        </div>
                    </div>
                </template>
            </YandexMapUiMarker>
            <YandexMapSignpost
                :settings="{
                    points: markers?.addresses.map((el) => el.point.coordinates) as LngLat[],
                }"
            />
        </YandexMap>
    </ClientOnly>
</template>

<script setup lang="ts">
    import type { LngLat } from '@yandex/ymaps3-types';
    import type { IContacts } from '~~/interfaces/contacts';

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
    const { content: markers } = useCms<IContacts>('contact');
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
