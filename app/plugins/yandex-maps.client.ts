import type { YMap, YMapEntity } from '@yandex/ymaps3-types';

interface YMapMarker {
  new (options: { coordinates: [number, number] }, element: HTMLElement): YMapEntity<unknown, {}> & { coordinates: [number, number] };
  coordinates?: [number, number];
}

interface YandexMapsAPI {
    ready: (callback: () => void) => void;
    import: (module: string) => Promise<any>;
    YMap: typeof YMap;
    YMapDefaultSchemeLayer: any;
    YMapDefaultFeaturesLayer: any;
    YMapMarker: YMapMarker;
    YMapSuggest?: any;
}

declare global {
    interface Window {
        ymaps3: YandexMapsAPI;
    }
}

export default defineNuxtPlugin((nuxtApp) => {
    const config = useRuntimeConfig();
    const isServer = import.meta.server;

    const API_KEY = config.public.yandexApiKey;

    if (isServer) return;

    return new Promise<void>((resolve) => {
        if (window.ymaps3) {
            resolve();
            return;
        }

        const script = document.createElement('script');
        script.src = `https://api-maps.yandex.ru/v3/?apikey=${API_KEY}&lang=ru_RU`;
        script.async = true;

        script.onload = () => {
            resolve();
        };

        document.head.appendChild(script);
    });
});
