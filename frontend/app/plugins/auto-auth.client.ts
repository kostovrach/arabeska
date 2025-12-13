export default defineNuxtPlugin(async () => {
    const userStore = useUserStore();

    try {
        const { user, success, message } = await $fetch('/api/auth/me');

        if (user && success) {
            userStore.setUser(user);
        } else {
            console.warn('Auth failed:', message);
            userStore.clearUser();
        }
    } catch (err) {
        console.warn('Auth failed:', err);
        userStore.clearUser();
    }
});
