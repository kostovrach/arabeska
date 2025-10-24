// server/api/[resource]/[id].get.js
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import path from 'path';
import { eventHandler, getRouterParam, createError } from 'h3';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const db = JSON.parse(readFileSync(path.join(__dirname, '/db.json'), 'utf-8'));

export default eventHandler((event) => {
    const resource = getRouterParam(event, 'resource'); // Например, "products"
    const id = getRouterParam(event, 'id'); // Например, "c94a78d4-3a6c-48a3-8571-5cfb79e12ed8"

    if (!db[resource]) {
        throw createError({
            statusCode: 404,
            statusMessage: `Resource ${resource} not found`,
        });
    }

    const item = db[resource].find((item) => item.id === id);
    if (item) {
        return item;
    } else {
        throw createError({
            statusCode: 404,
            statusMessage: `Item with id ${id} not found in ${resource}`,
        });
    }
});
