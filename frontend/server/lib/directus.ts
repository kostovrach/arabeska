import { createDirectus, rest, staticToken } from '@directus/sdk';

export function getDirectus() {
    const config = useRuntimeConfig();

    return createDirectus(config.directus.url)
        .with(rest())
        .with(staticToken(config.directus.token));
}
