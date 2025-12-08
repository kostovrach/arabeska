import type { IUser } from '~~/interfaces/entities/user';

export const useUserStore = defineStore('user', () => {
    const user = useState<IUser | null>('user', () => null);
    const isAuth = useState<boolean>('isAuth', () => false);

    function setUser(payload: IUser): void {
        user.value = payload;
        isAuth.value = true;
    }

    function clearUser(): void {
        user.value = null;
        isAuth.value = false;
    }

    async function logout(): Promise<void> {
        await $fetch('/api/auth/logout', { method: 'POST' });
        clearUser();
    }

    return { user, isAuth, setUser, clearUser, logout };
});
