import type { IAccessory } from '~/interfaces/accessory';

export default defineStore('accessories', () => {
    // Tech===========================
    const apiBase = useRuntimeConfig().public.apiBase;

    // State==========================
    const accessories = ref<IAccessory[]>([]);
    const accessoriesItem = ref<IAccessory | Object>({});

});
