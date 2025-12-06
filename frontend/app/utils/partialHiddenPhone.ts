export function partialHiddenPhone(
    phone: string,
    positions: number[] = [5, 6, 9, 10, 11],
    replacement: string = '*'
): string {
    if (phone.length < Math.max(...positions)) return phone;

    let digits = phone.split('');
    positions.forEach((pos) => {
        digits[pos] = replacement;
    });
    return digits.join('');
}
