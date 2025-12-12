import type { IProduct } from '~~/interfaces/entities/product';

export const useViewsStore = defineStore('views', () => {
    const STORAGE_KEY = 'views';
    const MAX_VIEWS = 20;
    const isClient = import.meta.client;

    // State
    const viewsProducts = ref<string[]>([]);

    // Actions
    function initFromLocalStorage(): void {
        if (!isClient) return;

        const products = localStorage.getItem(STORAGE_KEY);
        if (products) {
            try {
                let loadedViews: string[] = JSON.parse(products);
                if (!Array.isArray(loadedViews)) {
                    loadedViews = [];
                }
                if (loadedViews.length > MAX_VIEWS) {
                    loadedViews = loadedViews.slice(-MAX_VIEWS);
                }
                viewsProducts.value = loadedViews;
            } catch {                
                viewsProducts.value = [];
            }
        }
    }

    function setProductInViews(id: IProduct['id']): void {
        if (!isClient) return;
        if (!id.toString().length) return;

        const idStr = id.toString();
        let currentViews: string[] = viewsProducts.value;

        if (currentViews.includes(idStr)) return;

        currentViews.push(idStr);

        if (currentViews.length > MAX_VIEWS) {
            currentViews = currentViews.slice(-MAX_VIEWS);
        }

        localStorage.setItem(STORAGE_KEY, JSON.stringify(currentViews));
        viewsProducts.value = [...currentViews];
    }

    function clearViews(): void {
        if (!isClient) return;

        localStorage.removeItem(STORAGE_KEY);
        viewsProducts.value = [];
    }

    return { viewsProducts, initFromLocalStorage, setProductInViews, clearViews };
});
