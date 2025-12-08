export default defineEventHandler((event): { status: number; success: boolean } => {
    try {
        deleteCookie(event, 'authorization', {
            path: '/',
            sameSite: 'strict',
        });

        return { status: 200, success: true };
    } catch (err) {
        console.error(err);
        return { status: 500, success: false };
    }
});
