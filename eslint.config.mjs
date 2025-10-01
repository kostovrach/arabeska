// @ts-check
import withNuxt from './.nuxt/eslint.config.mjs';
import prettier from '@vue/eslint-config-prettier';

/** @type {Object} */
const customCfg = {
    ignores: ['**/dist/**', '**/.nuxt/**', '**/coverage/**', '**/scripts/**'],
    files: ['**/*.{ts,tsx,js,mjs,jsx,vue}'],
    languageOptions: {
        parserOptions: {
            extraFileExtensions: ['.vue'],
            project: ['./tsconfig.json'],
        },
    },
    rules: {
        'vue/multi-word-component-names': 'off',
        '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
    },
    prettier,
};

export default withNuxt(customCfg);
