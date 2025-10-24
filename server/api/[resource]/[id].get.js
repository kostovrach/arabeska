import { eventHandler, getRouterParam, createError } from 'h3';
import { readFileSync } from 'fs';
import path from 'path';

export default eventHandler((event) => {
  try {
    const dbPath = path.join(process.cwd(), 'db.json'); // Читаем из корня сборки
    const db = JSON.parse(readFileSync(dbPath, 'utf-8'));

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
  } catch (error) {
    console.error('Error reading db.json:', error); // Логи для Vercel
    throw createError({
      statusCode: 500,
      statusMessage: `Internal server error: ${error.message}`,
    });
  }
});