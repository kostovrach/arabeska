import type { AsyncData, AsyncDataOptions, AsyncDataRequestStatus } from '#app';
import type { IProduct } from '~/interfaces/product';

export const useAccessoriesStore = defineStore('accessories', () => {
    const apiBase = useRuntimeConfig().public.apiBase;

    // State===============================================
    const accessoriesList = useState<IProduct[] | null>('accessoriesList', () => null);
    const accessoriesStatus = useState<AsyncDataRequestStatus>('accessoriesStatus', () => 'idle');

    // Actions=============================================
    async function getAccessories(opt?: AsyncDataOptions<IProduct[]>) {
        const { data, status } = useLazyFetch<IProduct[]>(`${apiBase}/accessories`, {
            key: 'accessories',
            transform: (items) => items.filter((item) => item.available === true),
            ...opt,
        }) as AsyncData<IProduct[], Error>;

        watchEffect(() => {
            accessoriesStatus.value = status.value;
            if (data.value) accessoriesList.value = data.value;
        });
    }

    return { accessoriesList, accessoriesStatus, getAccessories };
});
