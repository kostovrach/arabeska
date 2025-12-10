// import type { ICartItem } from '~~/interfaces/entities/cart-item';

// const userStore = useUserStore();

// export const useCartStore = defineStore('cart', () => {
//     const cartList = useState<ICartItem[] | null>('cartList', () =>
//         userStore.user?.cart?.length ? [...userStore.user?.cart] : null
//     );

//     const isAuth = computed(() => userStore.isAuth);

//     async function addToCart(product: ICartItem): Promise<void> {
//         if (isAuth) {
//             if (Array.isArray(cartList.value)) {
//                 cartList.value.push(product);
//             } else {
//                 cartList.value = [product];
//             }

//             try {
//                 await $fetch('/api/user/update', {
//                     method: 'POST',
//                     body: { cart: cartList.value },
//                 });
//             } catch (err) {
//                 console.log(err);
//             }
//         }
//     }

//     return { cartList, addToCart };
// });
