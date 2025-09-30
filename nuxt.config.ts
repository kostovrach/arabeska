import { defineNuxtConfig } from 'nuxt/config';
import { fileURLToPath } from 'node:url';
import path from 'path';
import { createSvgIconsPlugin } from 'vite-plugin-svg-icons';
import legacy from '@vitejs/plugin-legacy';

const rootDir = fileURLToPath(new URL('.', import.meta.url));

export default defineNuxtConfig({
    compatibilityDate: '2025-07-15',

    ssr: false, // temp SPA

    devtools: { enabled: true },

    modules: ['@nuxt/eslint', '@pinia/nuxt'],

    typescript: {
        strict: true,
        typeCheck: true,
    },

    vite: {
        plugins: [
            createSvgIconsPlugin({
                iconDirs: [path.resolve(rootDir, 'assets/icons')],
                symbolId: 'icon-[name]',
                inject: 'body-last',
            }),

            legacy({
                targets: ['defaults', 'not IE 11'],
            }),
        ],
    },
});
