import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import path from 'path';
import { eventHandler, getRouterParam, createError } from 'h3';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const db = JSON.parse(readFileSync(path.join(__dirname, '/db.json'), 'utf-8'));

export default eventHandler((event) => {
  const resource = getRouterParam(event, 'resource'); // Например, "products"

  if (!db[resource]) {
    throw createError({
      statusCode: 404,
      statusMessage: `Resource ${resource} not found`,
    });
  }

  return db[resource]; // Возвращает массив, например, db.products
});