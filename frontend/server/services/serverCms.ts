import { directus } from './directus';
import { readItems, readItem } from '@directus/sdk';

function expandFields(fields?: string[], relations?: string[]) {
    let f: string[] = [];

    if (fields && fields.length) f.push(...fields);
    else f.push('*');

    if (relations && relations.length) {
        for (const r of relations) {
            const rel = r.trim();
            if (!rel) continue;

            if (!f.includes(rel)) f.push(rel);
            f.push(`${rel}.*`);
        }
    }

    return f;
}

function normalize(res: any) {
    if (!res) return null;
    // { data: [...] } или { data: { ... } }
    if (typeof res === 'object' && 'data' in res) {
        const d = res.data;
        if (Array.isArray(d)) return d;
        if (d && typeof d === 'object') return d;
        return null;
    }
    // массив
    if (Array.isArray(res)) return res;
    // одиночный объект
    if (typeof res === 'object') return res;

    return null;
}

export async function getDirectusCollection<T = any>(
    collection: string,
    params: {
        fields?: string[];
        relations?: string[];
        filter?: any;
        sort?: string;
        limit?: number;
    } = {}
): Promise<T> {
    const fields = expandFields(params.fields, params.relations);

    const query: any = { fields };

    if (params.filter) query.filter = params.filter;
    if (params.sort) query.sort = params.sort;
    if (params.limit !== undefined) query.limit = params.limit;

    const res = await directus.request(readItems(collection, query));

    return normalize(res);
}

export async function getDirectusItem<T = any>(
    collection: string,
    id: string | number,
    params: {
        fields?: string[];
        relations?: string[];
    } = {}
): Promise<T | null> {
    const fields = expandFields(params.fields, params.relations);

    const query: any = { fields };

    const res = await directus.request(readItem(collection, id, query));

    return normalize(res);
}
