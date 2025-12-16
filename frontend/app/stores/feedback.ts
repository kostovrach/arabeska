import type { AsyncDataRequestStatus } from '#app';
import type { IFeedback } from '~~/interfaces/feedback';

export const useFeedbackStore = defineStore('feedback', () => {
    // State===============================================
    const feedbackList = useState<IFeedback[] | null>('feedbackList', () => null);
    const feedbackStatus = useState<AsyncDataRequestStatus>('feedbackStatus', () => 'idle');

    const feedbackItem = useState<IFeedback | null>('feedbackItem', () => null);
    const feedbackItemStatus = useState<AsyncDataRequestStatus>('feedbackItemStatus', () => 'idle');

    // Actions=============================================
    async function getFeedback() {
        const { content: feedbackRaw, status } = await useCms<IFeedback[]>('feedback', [], {
            lazy: true,
        });

        const feedback = computed(() => feedbackRaw.value?.filter((el) => el.available === true));

        watchEffect(() => {
            feedbackStatus.value = status.value;
            if (feedback.value) feedbackList.value = feedback.value;
        });
    }

    async function getFeedbackById(id: number | string) {
        if (!id) {
            feedbackItemStatus.value = 'error';
            return;
        } else {
            const { content: feedbackRaw, status } = await useCms<IFeedback[]>('feedback', [], {
                lazy: true,
            });

            const feedback = computed(() =>
                feedbackRaw.value?.find((el) => el.id == id && el.available === true)
            );

            watchEffect(() => {
                feedbackItemStatus.value = status.value;
                if (feedback.value) feedbackItem.value = feedback.value ?? null;
            });
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
