export function isNewProduct(dateCreated: string | null | undefined, period?: number): boolean {
    if (!dateCreated) return false;

    const created = new Date(dateCreated);
    if (isNaN(created.getTime())) return false;

    const now = new Date();
    const diffInMs = now.getTime() - created.getTime();
    const daysDiff = diffInMs / (1000 * 60 * 60 * 24);

    return daysDiff < (period || 14);
}
