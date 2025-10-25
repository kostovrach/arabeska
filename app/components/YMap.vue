<template>
    <ClientOnly>
        <div class="map-container">
            <input
                ref="suggestInput"
                type="text"
                placeholder="Введите адрес"
                class="suggest-input"
            />
            <div ref="mapContainer" style="width: 900px; height: 500px"></div>
        </div>
    </ClientOnly>
</template>

<script setup lang="ts">
    import type { YMap, YMapEntity } from '@yandex/ymaps3-types';

    // Ссылки на DOM-элементы
    const mapContainer = ref<HTMLElement | null>(null);
    const suggestInput = ref<HTMLInputElement | null>(null);

    // Список адресов магазинов Arabeska
    const shopAddresses: {
        coordinates: [number, number];
        name: string;
    }[] = [
        { coordinates: [50.159656, 53.196586], name: 'Проспект Кирова, 22' },
        { coordinates: [50.116667, 53.2], name: 'Улица Ленина, 15, ТЦ «Аврора», офис 21' },
        { coordinates: [50.12, 53.21], name: 'Площадь Славы, 5' },
    ];

    onMounted(async () => {
        // Ждём загрузки Yandex Maps API
        await new Promise((resolve) => window.ymaps3.ready(() => resolve));

        // Инициализация карты
        const { YMap, YMapDefaultSchemeLayer, YMapDefaultFeaturesLayer, YMapMarker } =
            window.ymaps3;

        const map = new YMap(
            mapContainer.value!,
            {
                location: {
                    center: [50.100202, 53.195873], // Центр Самары
                    zoom: 12,
                },
            },
            [new YMapDefaultSchemeLayer({}), new YMapDefaultFeaturesLayer({})]
        );

        // Добавляем метки для магазинов Arabeska
        shopAddresses.forEach(({ coordinates, name }) => {
            const markerElement = document.createElement('div');
            markerElement.innerHTML = `
      <div style="width: 32px; height: 32px; background: blue; border-radius: 50%; position: relative;">
        <span style="position: absolute; top: -30px; left: 50%; transform: translateX(-50%); background: white; padding: 2px 5px; border-radius: 3px; font-size: 12px; white-space: nowrap;">
          ${name}
        </span>
      </div>`;
            const marker = new YMapMarker({ coordinates }, markerElement);
            map.addChild(marker);
        });

        // Инициализация Yandex Suggest
        const { YMapSuggest } = await window.ymaps3.import('@yandex/ymaps3-suggest@0.0.2');
        const suggest = new YMapSuggest(suggestInput.value!, {
            provider: {
                async suggest(query: string) {
                    const { data } = await useFetch(
                        `https://suggest-maps.yandex.ru/v1/suggest?apikey=${
                            useRuntimeConfig().public.yandexMapsApiKey
                        }&text=${encodeURIComponent(query)}&lang=ru_RU&bbox=49.8,53.0,50.4,53.4`
                    );
                    return (data.value as any)?.results || [];
                },
            },
        });

        // Обработка выбора адреса
        suggest.on('select', async (event: any) => {
            const address = event.item?.value;
            if (!address) return;

            // Геокодирование адреса
            const { data, error } = await useFetch(
                `https://geocode-maps.yandex.ru/1.x/?apikey=${
                    useRuntimeConfig().public.yandexMapsApiKey
                }&geocode=${encodeURIComponent(address)}&format=json&lang=ru_RU`
            );

            if (error.value) {
                console.error('Ошибка геокодирования:', error.value);
                return;
            }

            const coordinates = (
                data.value as any
            )?.response?.GeoObjectCollection?.featureMember?.[0]?.GeoObject?.Point?.pos
                ?.split(' ')
                .map(Number)
                .reverse() as [number, number];

            if (coordinates) {
                // Удаляем старую пользовательскую метку, если она есть
                const oldMarker = map.children.find(
                    (child: YMapEntity<unknown, {}>) =>
                        child instanceof YMapMarker &&
                        !shopAddresses.some(
                            (shop) =>
                                shop.coordinates[0] === child.coordinates?.[0] &&
                                shop.coordinates[1] === child.coordinates?.[1]
                        )
                );
                if (oldMarker) {
                    map.removeChild(oldMarker);
                }

                // Добавляем новую пользовательскую метку
                const markerElement = document.createElement('div');
                markerElement.innerHTML =
                    '<div style="width: 32px; height: 32px; background: red; border-radius: 50%;"></div>';
                const marker = new YMapMarker({ coordinates }, markerElement);
                map.addChild(marker);

                // Центрируем карту на новой метке
                map.setLocation({ center: coordinates, zoom: 14, duration: 500 });
            }
        });
    });
</script>

<style scoped>
    .map-container {
        width: 100%;
        max-width: 800px;
        margin: 0 auto;
    }
    .suggest-input {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        font-size: 16px;
    }
</style>
