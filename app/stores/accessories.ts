import type { Accessory } from '~/interfaces/accessory';

export default defineStore('accessories', () => {
    // Tech===========================
    const apiBase = useRuntimeConfig().public.apiBase;

    // State==========================
    const accessories = ref<Accessory[]>([]);
    const accessoriesItem = ref<Accessory | Object>({});

});
