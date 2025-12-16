export const useDeliveryPriceCalculator = (
    amount: ComputedRef<number>,
    defaultPrice: ComputedRef<number>,
    requiredPrice: ComputedRef<number>
) => {
    const remains = computed(() => {
        if (!defaultPrice.value || !requiredPrice.value) return 0;
        if (requiredPrice.value <= 0 || amount.value >= requiredPrice.value) return 0;

        return requiredPrice.value - amount.value;
    });
    const remainsPercent = computed(() => {
        if (!defaultPrice.value || !requiredPrice.value || amount.value === 0) return 0;
        if (requiredPrice.value <= 0 || amount.value >= requiredPrice.value) return 100;

        const missing = requiredPrice.value - amount.value;
        return Math.round((missing / requiredPrice.value) * 100);
    });
    const price = computed(() => (remains.value > 0 ? defaultPrice.value : 0));

    return { remains, remainsPercent, price };
};
