<template>
    <ClientOnly>
        <div class="map-zones">
            <div class="map-zones__header">
                <h3 class="map-zones__title">Проверьте адрес доставки</h3>
                <div class="map-zones__validator"></div>
            </div>

            <YandexMap
                class="map-zones__map"
                :settings="{
                    location: {
                        center: [50.18, 53.22],
                        zoom: 11,
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
                    <YandexMapSearchControl
                        :settings="{
                            searchResult: (val) => {},
                        }"
                    />
                </YandexMapControls>
                <YandexMapControls :settings="{ position: 'left bottom' }">
                    <YandexMapOpenMapsButton />
                </YandexMapControls>

                <YandexMapFeature
                    v-for="(feature, idx) in features"
                    :key="idx"
                    :settings="{
                        ...feature.settings,
                        onClick: (event, mapEvent) => setMarkerCoordinates(event, mapEvent, idx),
                    }"
                >
                    <YandexMapUiMarker
                        v-if="activeMarker === idx"
                        :settings="{
                            coordinates: markerCoordinates,
                            color: 'green',
                            title: feature.title,
                            subtitle: `Стоимость: ${feature.price}₽`,
                        }"
                    />
                </YandexMapFeature>
            </YandexMap>
        </div>
    </ClientOnly>
</template>

<script setup lang="ts">
    import type { LngLat, YMapFeatureProps } from '@yandex/ymaps3-types';
    import type { MapEvent } from '@yandex/ymaps3-types/imperative/YMapFeature/types';

    import {
        YandexMap,
        YandexMapDefaultSchemeLayer,
        YandexMapDefaultFeaturesLayer,
        YandexMapUiMarker,
        YandexMapControls,
        YandexMapZoomControl,
        YandexMapGeolocationControl,
        YandexMapOpenMapsButton,
        YandexMapSearchControl,
        YandexMapFeature,
        YandexMapDefaultMarker,
    } from 'vue-yandex-maps';

    const markerCoordinates = ref<LngLat>([0, 0]);
    const activeMarker = ref<number | null>(null);
    function setMarkerCoordinates(event: MouseEvent, mapEvent: MapEvent, idx: number): void {
        markerCoordinates.value = mapEvent.coordinates;
        activeMarker.value = idx;
    }

    const defaultSettings = {
        geometry: {
            type: 'Polygon',
        },
        style: {
            stroke: [
                {
                    width: 2,
                },
            ],
        },
    } satisfies Omit<YMapFeatureProps, 'geometry'> & {
        geometry: Partial<YMapFeatureProps['geometry']>;
    };

    const ZONE_1_COORDINATES: LngLat[] = [
        [50.06445687695311, 53.17157211178392],
        [50.076246760620215, 53.18562050270492],
        [50.09483728448499, 53.199701084705005],
        [50.12569280834973, 53.213729334549285],
        [50.1519971840822, 53.22703849778011],
        [50.1718924963379, 53.217850204677035],
        [50.2117852902832, 53.21191922431797],
        [50.21377908422843, 53.19239505875439],
        [50.14200289843757, 53.19017998359569],
        [50.104065734131, 53.180358424338195],
        [50.06445687695311, 53.17157211178392],
    ];

    const ZONE_2_COORDINATES: LngLat[] = [
        [50.3658942548828, 53.29632570649176],
        [50.287733577026465, 53.303926118653905],
        [50.234569645324825, 53.306421172097735],
        [50.18577429028333, 53.26051813796128],
        [50.1519971840822, 53.22703849778011],
        [50.1718924963379, 53.217850204677035],
        [50.21206481625889, 53.21273243393651],
        [50.21373348657074, 53.19233107792712],
        [50.277162365354876, 53.20753509043999],
        [50.41929798547207, 53.25032202289644],
        [50.3658942548828, 53.29632570649176],
    ];

    const features: {
        title: string;
        price: number;
        settings: YMapFeatureProps;
    }[] = [
        {
            title: 'Тариф 1',
            price: 100,
            settings: {
                ...defaultSettings,
                geometry: {
                    ...defaultSettings.geometry,
                    coordinates: [ZONE_1_COORDINATES],
                },
                style: {
                    stroke: [
                        {
                            color: 'rgba(56, 56, 219, 1)',
                        },
                    ],
                    fill: 'rgba(56, 56, 219, 0.5)',
                },
            },
        },
        {
            title: 'Тариф 2',
            price: 250,
            settings: {
                ...defaultSettings,
                geometry: {
                    ...defaultSettings.geometry,
                    coordinates: [ZONE_2_COORDINATES],
                },
                style: {
                    stroke: [
                        {
                            color: 'rgba(252, 172, 2, 1)',
                        },
                    ],
                    fill: 'rgba(252, 172, 2, 0.5)',
                },
            },
        },
    ];
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .map-zones {
        display: flex;
        flex-direction: column;
        gap: rem(16);
        &__title {
            font-size: lineScale(18, 16, 480, 1440);
            opacity: 0.5;
        }
        &__map {
            width: 100%;
            aspect-ratio: 2/1;
            border-radius: rem(32);
            overflow: hidden;
        }
    }
</style>
