import type { AsyncData, AsyncDataOptions, AsyncDataRequestStatus } from '#app';
import type { IProduct } from '~~/interfaces/product';

export const useCertificatesStore = defineStore('certificates', () => {
    const apiBase = useRuntimeConfig().public.apiBase;

    // State===============================================
    const certificatesList = useState<IProduct[] | null>('certificatesList', () => null);
    const certificatesItem = useState<IProduct | null>('certificatesItem', () => ({}) as IProduct);
    const certificatesStatus = useState<AsyncDataRequestStatus>('certificatesStatus', () => 'idle');
    const singleCertificateStatus = useState<AsyncDataRequestStatus>(
        'singleCertificatesStatus',
        () => 'idle'
    );

    // Actions=============================================
    async function getCertificates(opt?: AsyncDataOptions<IProduct[]>) {
        const { data, status } = useLazyFetch<IProduct[]>(`${apiBase}/certificates`, {
            key: 'certificates',
            ...opt,
        }) as AsyncData<IProduct[], Error>;

        watchEffect(() => {
            certificatesStatus.value = status.value;
            if (data.value) certificatesList.value = data.value;
        });
    }

    async function getCertificateById(
        id: string | string[] | undefined,
        opt?: AsyncDataOptions<IProduct>
    ) {
        if (typeof id === 'string') {
            const { data, status } = (await useFetch<IProduct>(`${apiBase}/certificates/${id}`, {
                key: `certificate-${id}`,
                ...opt,
            })) as AsyncData<IProduct, Error>;

            singleCertificateStatus.value = status.value;
            certificatesItem.value = data.value;
        } else {
            singleCertificateStatus.value = 'error';
        }
    }

    return {
        certificatesList,
        certificatesItem,
        certificatesStatus,
        singleCertificateStatus,
        getCertificates,
        getCertificateById,
    };
});
