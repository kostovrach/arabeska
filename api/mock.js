import { createRouter } from 'h3';
import db from '../db.json' assert { type: 'json' };

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
