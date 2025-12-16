export function cartKeyBuilder(keys: any[]): string {
    const stringify = keys.map((el) => JSON.stringify(el));
    return stringify.join(':');
}
