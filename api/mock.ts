import { createRouter } from 'h3';
import { readFileSync } from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const db = JSON.parse(readFileSync(path.join(__dirname, '../db.json'), 'utf-8'));

const router = createRouter();

router.get('/:resource', (req, res) => {
  const resource = req.params.resource;
  if (db[resource]) {
    return res.json(db[resource]);
  } else {
    res.status(404).json({ error: `Resource ${resource} not found` });
  }
});

export default router.handler;