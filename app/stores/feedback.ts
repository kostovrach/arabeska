import type { AsyncData, AsyncDataOptions, AsyncDataRequestStatus } from '#app';
import type { IFeedback } from '~/interfaces/feedback';

export const useFeedbackStore = defineStore('feedback', () => {
    const apiBase = useRuntimeConfig().public.apiBase;

    // State===============================================
    const feedbackList = useState<IFeedback[] | null>('feedbackList', () => null);
    const feedbackStatus = useState<AsyncDataRequestStatus>('feedbackStatus', () => 'idle');

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

    return {
        feedbackList,
        feedbackStatus,
        getFeedback,
    };
});
