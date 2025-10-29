import type { H3Event } from 'h3';
import { fetchItem, fetchList } from '../../services/directusData';

export default defineCachedEventHandler(
    async (event: H3Event) => {
        // console.log(event);

        const config = useRuntimeConfig();

        try {
            let q: Record<string, string> = {};
            const url = event.req.url;
            if (url) {
                const parsed = new URL(url, config.public.urlBase); // базовый host нужен только для парсинга
                q = Object.fromEntries(parsed.searchParams.entries());
            }
            // Параметры запроса
            const { collection } = getRouterParams(event);

            if (!collection) {
                event.res.status = 400;
                event.res.statusText = 'collection is required';

                return { data: null, error: 'collection is required' };
            }

            // fields — строка с запятой или JSON-строка; если не указаны — в сервисе используется ['*']
            let fields: string[] | undefined;
            if (q.fields) {
                try {
                    // поддерживаем JSON и CSV
                    const raw = String(q.fields);
                    if (raw.trim().startsWith('[')) fields = JSON.parse(raw);
                    else
                        fields = raw
                            .split(',')
                            .map((s) => s.trim())
                            .filter(Boolean);
                } catch (e) {
                    // игнорируем и позволяем сервису установить дефолт
                }
            }

            // relations — CSV
            let relations: string[] | undefined;
            if (q.relations) {
                relations = String(q.relations)
                    .split(',')
                    .map((s) => s.trim())
                    .filter(Boolean);
            }

            // filter — ожидаем JSON (stringified)
            let filter: any | undefined;
            if (q.filter) {
                try {
                    filter = typeof q.filter === 'string' ? JSON.parse(q.filter) : q.filter;
                } catch (e) {
                    // неверный формат filter
                    event.res.status = 400;
                    event.res.statusText = 'invalid filter JSON';
                    return { data: null, error: 'invalid filter JSON' };
                }
            }

            // sort, limit, id, resolveFiles, force
            const sort = q.sort ? String(q.sort) : undefined;
            const limit = q.limit !== undefined ? Number(q.limit) : undefined;
            // const id = q.id ? String(q.id) : undefined;
            const resolveFiles =
                q.resolveFiles !== undefined ? String(q.resolveFiles) !== 'false' : true;
            const force = q.force === '1' || q.force === 'true';

            // options для сервиса
            const opts = {
                resolveFiles,
                force,
                memoryTtl: undefined as number | undefined,
            };

            // Если указан id — считаем, что нужно вернуть один элемент
            // if (id) {
            //     // Поддержка поля id как uuid или прямой фильтр по primary key
            //     const params = {
            //         fields: fields ?? ['*', ...(relations ?? [])],
            //         filter: { id: { _eq: id } },
            //         limit: 1,
            //     };
            //     const item = await fetchItem(collection, params, opts);
            //     return { data: item };
            // }

            // В остальных случаях возвращаем список
            const params = { fields: fields ?? ['*', ...(relations ?? [])], filter, sort, limit };
            const item = await fetchList(collection, params, opts);

            return { data: item };
        } catch (err: any) {
            event.res.status = 500;
            event.res.statusText = err;
            return { data: null, error: String(err?.message || err) };
        }
    },
    {
        maxAge: 60,
    }
);
