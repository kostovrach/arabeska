import type { IUser } from '~~/interfaces/entities/user';

export const useUserStore = defineStore('user', () => {
    const user = useState<Omit<IUser, 'password'> | null>('user', () => null);
    const isAuth = useState<boolean>('isAuth', () => false);

    function setUser(payload: Omit<IUser, 'password'>): void {
        user.value = payload;
        isAuth.value = true;
    }

    function clearUser(): void {
        user.value = null;
        isAuth.value = false;
    }

    async function updateUser(payload: Partial<IUser>): Promise<{ ok: boolean }> {
        const res = await $fetch('/api/user/update', { method: 'POST', body: payload });

        if (res.success) {
            await nextTick();

            const { user, success } = await $fetch('/api/auth/me');

            if (user && success) {
                setUser(user);

                return { ok: true };
            } else return { ok: false };
        } else return { ok: false };
    }

    async function logout(): Promise<void> {
        await $fetch('/api/auth/logout', { method: 'POST' });
        clearUser();
    }

    return { user, isAuth, setUser, clearUser, updateUser, logout };
});
