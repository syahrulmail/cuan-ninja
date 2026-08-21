import { env } from 'cloudflare:workers';
import { createDatabase } from '../../../lib/db.js';

// Records a product click without redirecting.
// Used when the product detail modal is opened.
export async function POST({ params, request }) {
  const slug = params.slug;

  if (!slug) {
    return new Response('Not Found', { status: 404 });
  }

  const db = createDatabase(env.cuan_db);
  const product = await db.getProductBySlug(slug);

  if (!product) {
    return new Response('Not Found', { status: 404 });
  }

  const referrer = request.headers.get('referer');
  const userAgent = request.headers.get('user-agent');
  const country = request.headers.get('cf-ipcountry') || 'unknown';

  await db.trackClick({
    product_slug: slug,
    referrer,
    user_agent: userAgent,
    country
  });

  return new Response('ok', { status: 200 });
}
