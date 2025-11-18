<template>
    <ClientOnly>
        <div class="map-zones">
            <div class="map-zones__header">
                <h3 class="map-zones__title">Проверьте адрес доставки</h3>
            </div>

            <YandexMap
                v-model="map"
                class="map-zones__map"
                width="100%"
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

                <YandexMapControls :settings="{ position: 'top left' }">
                    <yandex-map-search-control
                        :settings="{
                            placeholder: 'Введите улицу и № дома',
                            searchResult: (val) =>
                                (selectedInput = val[0]?.geometry?.coordinates ?? null),
                        }"
                    />
                </YandexMapControls>

                <YandexMapUiMarker
                    v-if="selectedInput"
                    :settings="{
                        coordinates: selectedInput,
                        color: 'green',
                        title: 'Результат поиска',
                    }"
                />

                <YandexMapControls :settings="{ position: 'left bottom' }">
                    <YandexMapOpenMapsButton />
                </YandexMapControls>

                <YandexMapFeature
                    v-for="(feature, idx) in zones"
                    :key="feature.id"
                    :settings="{
                        geometry: {
                            type: 'Polygon',
                            coordinates: feature.point.coordinates,
                        },
                        style: {
                            stroke: [
                                {
                                    color: feature.color,
                                    width: 2,
                                },
                            ],
                            fill: feature.color,
                            fillOpacity: 0.3,
                            cursor: 'pointer',
                        },
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
    // types ===========================================================================
    import type { YMap, LngLat } from '@yandex/ymaps3-types';
    import type { MapEvent } from '@yandex/ymaps3-types/imperative/YMapFeature/types';

    interface IDeliveryZones {
        id: number | string;
        date_created: string;
        date_updated?: string;

        title: string;
        price: number;
        color: string;
        point: {
            type: string;
            coordinates: LngLat[][];
        };
    }
    // =================================================================================

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
    } from 'vue-yandex-maps';

    // state =========================================================================
    const markerCoordinates = ref<LngLat>([0, 0]);
    const activeMarker = ref<number | null>(null);

    const selectedSearch = ref<LngLat | null>(null);
    const selectedInput = ref<LngLat | null>(null);

    const search = ref('');
    const map = shallowRef<YMap | null>(null);

    function sleep(ms: number) {
        return new Promise((resolve) => setTimeout(resolve, ms));
    }

    watch(search, async (val) => {
        if (!val) return;

        if (val.split(/[,.]/).length === 4) {
            selectedSearch.value = val.split(',').map((x) => parseFloat(x)) as LngLat;
            return;
        }

        await sleep(300);
        if (val !== search.value) return;
    });
    // ===============================================================================

    // data ==========================================================================
    const { content: zones } = useCms<IDeliveryZones[]>('delivery_zones');
    // ===============================================================================

    function setMarkerCoordinates(event: MouseEvent, mapEvent: MapEvent, idx: number): void {
        markerCoordinates.value = mapEvent.coordinates;
        activeMarker.value = idx;
    }
</script>

<style scoped lang="scss">
    @use '~/assets/scss/abstracts' as *;

    .map-zones {
        display: flex;
        flex-direction: column;
        gap: rem(16);
        font-family: 'Inter', sans-serif;
        &__title {
            font-size: lineScale(18, 16, 480, 1440);
            opacity: 0.5;
        }
        &__map {
            width: 100%;
            aspect-ratio: 2/1;
            border-radius: rem(32);
            overflow: hidden;

            @media (max-width: 768px) {
                aspect-ratio: 1.4/1;
            }
        }
    }
</style>
