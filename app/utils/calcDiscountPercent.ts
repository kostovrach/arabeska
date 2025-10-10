export const calcDiscountPercent = (currentPrice: number, discountedPrice: number): string => {
    const result = (((currentPrice - discountedPrice) / currentPrice) * 100).toFixed(0);
    return result;
};
