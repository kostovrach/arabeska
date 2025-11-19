// import { normalizePhone } from '~~/server/utils/normalizePhone';
// import { getAmoClient } from './client';
// import { IUser } from '~~/interfaces/entities/user';

// export async function findOrCreateContact(data: {
//     name?: string;
//     phone: string | number;
//     email?: string;
// }) {
//     const client = await getAmoClient();
//     const phoneDigits = normalizePhone(data.phone);

//     const search = await client.request.get<IUser>('/api/v4/contacts', {
//         query: phoneDigits,
//         limit: 1,
//     });
// }
