import { eventHandler, getRouterParam, createError } from 'h3';
import { readFileSync } from 'fs';
import path from 'path';

export default eventHandler((event) => {
  try {
    const dbPath = path.join(process.cwd(), 'db.json'); // Читаем из корня сборки
    const db = JSON.parse(readFileSync(dbPath, 'utf-8'));

    const resource = getRouterParam(event, 'resource'); // Например, "products"

    if (!db[resource]) {
      throw createError({
        statusCode: 404,
        statusMessage: `Resource ${resource} not found`,
      });
    }

    return db[resource]; // Возвращает массив, например, db.products
  } catch (error) {
    console.error('Error reading db.json:', error); // Логи для Vercel
    throw createError({
      statusCode: 500,
      statusMessage: `Internal server error: ${error.message}`,
    });
  }
});