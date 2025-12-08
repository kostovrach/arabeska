import { ModalsAuth } from '#components';
import { useModal } from 'vue-final-modal';

export default defineNuxtRouteMiddleware((to) => {
    const userStore = useUserStore();

    if (import.meta.server) return;

    const {
        open: openAuth,
        close: closeAuth,
        destroy: destroyAuth,
    } = useModal({
        component: ModalsAuth,
        attrs: {
            redirect: to.fullPath,
            onLoggedIn() {
                closeAuth();
                destroyAuth();
            },
            onClose() {
                closeAuth();
            },
        },
    });

    if (!userStore.isAuth) {
        openAuth();
        return abortNavigation();
    }
});
