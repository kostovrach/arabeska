import type { ICartItem } from '~~/interfaces/entities/cart-item';

export const useCartStore = defineStore('cart', () => {
    const userStore = useUserStore();
    const productsStore = useProductsStore();
    const isAuth = computed(() => userStore.isAuth);
    const isClient = import.meta.client;

    // State
    const cartList = ref<ICartItem[]>([]);

    // Getters
    const cartCount = computed(() => cartList.value.length);
    const cartAmount = computed(() => {
        return cartList.value.reduce((total, item) => {
            const product = productsStore.productsList?.find((el) => el.id === item.product_id);
            if (!product) return total;

            const price = (): number => {
                let multiplier: number;
                switch (item.modifier) {
                    case 'standart':
                        multiplier = 1;
                        return product.discount
                            ? product.discount * multiplier
                            : product.price * multiplier;
                    case 'large':
                        multiplier = 1.5;
                        return product.discount
                            ? product.discount * multiplier
                            : product.price * multiplier;
                    case 'premium':
                        multiplier = 2;
                        return product.discount
                            ? product.discount * multiplier
                            : product.price * multiplier;
                    default:
                        multiplier = 1;
                        return product.discount
                            ? product.discount * multiplier
                            : product.price * multiplier;
                }
            };
            return total + Number(item.quantity) * price();
        }, 0);
    });

    // Helpers
    function loadFromLocalStorage(): void {
        if (isClient && !isAuth.value) {
            const localCart = localStorage.getItem('cart');
            if (localCart) {
                cartList.value = JSON.parse(localCart);
            }
        } else return;
    }

    function saveToLocalStorage(): void {
        if (isClient && !isAuth.value) {
            localStorage.setItem('cart', JSON.stringify(cartList.value));
        } else return;
    }

    async function initCart(): Promise<void> {
        if (isClient) {
            loadFromLocalStorage();
            if (isAuth.value) await syncCart();
        }
    }

    // Actions
    async function addToCart(item: ICartItem): Promise<void> {
        const key = cartKeyBuilder([item.product_id, item.modifier]);
        const existingIdx = cartList.value.findIndex(
            (el) => cartKeyBuilder([el.product_id, el.modifier]) === key
        );

        const snapshot = [...cartList.value];

        if (existingIdx !== -1) {
            cartList.value[existingIdx]!.quantity =
                Number(cartList.value[existingIdx]?.quantity) + Number(item.quantity);
        } else {
            cartList.value.push({ ...item, quantity: Number(item.quantity) });
        }

        saveToLocalStorage();

        if (isAuth.value) {
            try {
                await $fetch('/api/cart/add', { method: 'POST', body: item });
                await syncCart();
            } catch (err) {
                cartList.value = snapshot;
                console.error('Error adding to cart:', err);
            }
        }
    }

    async function removeFromCart(item: ICartItem): Promise<void> {
        const key = cartKeyBuilder([item.product_id, item.modifier]);
        const existingIdx = cartList.value.findIndex(
            (el) => cartKeyBuilder([el.product_id, el.modifier]) === key
        );

        if (existingIdx === -1) return;

        const snapshot = [...cartList.value];

        cartList.value.splice(existingIdx, 1);
        saveToLocalStorage();

        if (isAuth.value) {
            try {
                await $fetch('/api/cart/remove', { method: 'POST', body: item });
                await syncCart();
            } catch (err) {
                cartList.value = snapshot;
                console.error('Error removing from cart:', err);
            }
        }
    }

    async function updateQty(item: ICartItem): Promise<void> {
        const key = cartKeyBuilder([item.product_id, item.modifier]);
        const existingIdx = cartList.value.findIndex(
            (el) => cartKeyBuilder([el.product_id, el.modifier]) === key
        );

        if (existingIdx === -1 || Number(item.quantity) <= 0) return;

        const snapshot = [...cartList.value];

        cartList.value[existingIdx]!.quantity = item.quantity;
        saveToLocalStorage();

        if (isAuth.value) {
            try {
                await $fetch('/api/cart/update', { method: 'POST', body: { item } });
                await syncCart();
            } catch (err) {
                cartList.value = snapshot;
                console.error('Error updating quantity:', err);
            }
        }
    }

    async function syncCart(): Promise<void> {
        if (isAuth.value) {
            try {
                const { cart: serverCart } = await $fetch('/api/cart');
                cartList.value = serverCart;
            } catch (err) {
                console.error('Error syncing cart:', err);
            }
        }
    }

    async function mergeCart(): Promise<void> {
        const cartStorage = localStorage.getItem('cart');

        if (isClient && cartStorage) {
            const localCart: ICartItem[] = JSON.parse(cartStorage);
            for (const item of localCart) {
                await addToCart(item);
            }
            localStorage.removeItem('cart');
        }
        await syncCart();
    }

    function checkItemInCart(item: ICartItem): boolean {
        const key = cartKeyBuilder([item.product_id, item.modifier]);
        const exist = cartList.value.find(
            (el) => cartKeyBuilder([el.product_id, el.modifier]) === key
        );

        if (exist) {
            return true;
        } else return false;
    }

    return {
        cartList,
        cartCount,
        cartAmount,
        initCart,
        addToCart,
        removeFromCart,
        updateQty,
        syncCart,
        mergeCart,
        checkItemInCart,
    };
});
