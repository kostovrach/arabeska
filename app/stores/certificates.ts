import type { Certificate } from '~/interfaces/certificate';

export default defineStore('certificates', () => {
    // Tech===========================
    const apiBase = useRuntimeConfig().public.apiBase;

    // State =========================
    const certificates = ref<Certificate[]>([]);
    const certificatesItem = ref<Certificate | Object>({});

});
