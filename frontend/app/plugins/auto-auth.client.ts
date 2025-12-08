export default defineNuxtPlugin(async () => {
    const userStore = useUserStore();

    try {
        const { user, success, message } = await $fetch('/api/auth/me');

        if (user && success) {
            userStore.setUser(user);
        } else {
            console.warn('Auto auth failed → logout, reason:', message);
            userStore.clearUser();
        }
    } catch (err) {
        console.warn('Auto auth failed → logout, reason:', err);
        userStore.clearUser();
    }
});
