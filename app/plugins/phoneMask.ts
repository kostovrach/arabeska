import vPhoneMask from '~/directives/vPhoneMask';

export default defineNuxtPlugin((nuxtApp) => {
    nuxtApp.vueApp.directive('phone-mask', vPhoneMask);
});
