import type { AsyncDataRequestStatus } from '#app';
import type { IFeedback } from '~~/interfaces/feedback';

export const useFeedbackStore = defineStore('feedback', () => {
    // State===============================================
    const feedbackList = ref<IFeedback[]>([]);

    // Actions=============================================
    function setFeedback(data: IFeedback[]) {
        feedbackList.value = data;
    }

    function getFeedbackById(id: IFeedback['id']) {
        const result = feedbackList.value.find((el) => el.id == id);

        return result ?? null;
    }

    return {
        feedbackList,
        setFeedback,
        getFeedbackById,
    };
});
