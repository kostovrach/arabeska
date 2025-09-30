import { defineNuxtPlugin } from '#app';
import SwiperCore from 'swiper';
import { Navigation, Pagination } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';

export default defineNuxtPlugin(() => {
    SwiperCore.use([Navigation, Pagination]);
});
