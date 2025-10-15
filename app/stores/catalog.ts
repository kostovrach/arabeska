import type { IProduct } from '~/interfaces/product';
import type { TypeCategories } from '~/types/catrgories';

export const useCatalogStore = defineStore('catalog', () => {

    const { productsList } = useProductsStore();
    const { certificatesList } = useCertificatesStore();
    const { accessoriesList } = useAccessoriesStore();

    // State=======================================================
    const catalogList = useState<IProduct[] | null>('catalogList', () => null);

    // Actions=====================================================
    async function getCatalogItems(endpoint: TypeCategories) {
        switch (endpoint) {
            case 'flowers':
                catalogList.value = productsList;
                break;
            case 'certificates':
                catalogList.value = certificatesList;
                break;
            case 'accessory':
                catalogList.value = accessoriesList;
                break;
            default:
                catalogList.value = productsList;
                break;
        }
    }

    return { catalogList, getCatalogItems };
});
