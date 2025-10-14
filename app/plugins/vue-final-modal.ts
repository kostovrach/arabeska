import { createVfm } from 'vue-final-modal';
import type { Vfm } from 'vue-final-modal';

export default defineNuxtPlugin((nuxtApp) => {
    const vfm = createVfm() as Vfm;

    nuxtApp.vueApp.use(vfm);
});
