import type { AsyncData, AsyncDataOptions, AsyncDataRequestStatus } from '#app';
import type { IFeedback } from '~~/interfaces/feedback';

export const useFeedbackStore = defineStore('feedback', () => {
    const apiBase = useRuntimeConfig().public.apiBase;

    // State===============================================
    const feedbackList = useState<IFeedback[] | null>('feedbackList', () => null);
    const feedbackStatus = useState<AsyncDataRequestStatus>('feedbackStatus', () => 'idle');

    const feedbackItem = useState<IFeedback | null>('feedbackItem', () => null);
    const feedbackItemStatus = useState<AsyncDataRequestStatus>('feedbackItemStatus', () => 'idle');

    // Actions=============================================
    async function getFeedback(opt?: AsyncDataOptions<IFeedback[]>) {
        const { data, status } = useLazyFetch<IFeedback[]>(`${apiBase}/feedback`, {
            key: 'feedback',
            ...opt,
        }) as AsyncData<IFeedback[], Error>;

        watchEffect(() => {
            feedbackStatus.value = status.value;
            if (data.value) feedbackList.value = data.value;
        });
    }

    async function getFeedbackById(
        id: string | string[] | number | undefined,
        opt?: AsyncDataOptions<IFeedback>
    ) {
        if (typeof id === 'string') {
            const { data, status } = (await useFetch<IFeedback>(`${apiBase}/feedback/${id}`, {
                key: `feedback-${id}`,
                ...opt,
            })) as AsyncData<IFeedback, Error>;

            feedbackItemStatus.value = status.value;
            feedbackItem.value = data.value;
        } else {
            feedbackItemStatus.value = 'error';
        }
    }

    return {
        feedbackList,
        feedbackStatus,
        feedbackItem,
        feedbackItemStatus,
        getFeedback,
        getFeedbackById,
    };
});
