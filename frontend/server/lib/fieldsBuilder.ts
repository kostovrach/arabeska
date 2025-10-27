type FieldsNode = string | (string | Record<string, any>)[];

export function buildFields(input: FieldsNode, maxDepth = 3): string {
    const out: string[] = [];

    const walk = (node: any, prefix = '', depth = 0) => {
        if (depth > maxDepth) return;
        if (node == null) return;

        if (typeof node === 'string') {
            out.push(prefix ? `${prefix}.${node}` : node);
            return;
        }
        if (Array.isArray(node)) {
            node.forEach((n) => walk(n, prefix, depth));
            return;
        }
        if (typeof node === 'object') {
            // object where keys are field names and values are true | nested array | string
            for (const [k, v] of Object.entries(node)) {
                if (v === true) {
                    out.push(prefix ? `${prefix}.${k}` : k);
                } else {
                    walk(v, prefix ? `${prefix}.${k}` : k, depth + 1);
                }
            }
        }
    };

    walk(input, '', 0);
    return out.join(',');
}
