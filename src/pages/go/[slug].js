import { env } from 'cloudflare:workers';
import { createDatabase } from '../../lib/db.js';

export async function GET({ params, request, redirect }) {
  const slug = params.slug;

  if (!slug) {
    return new Response('Not Found', { status: 404 });
  }

  const db = createDatabase(env.cuan_db);
  const product = await db.getProductBySlug(slug);

  if (!product) {
    return new Response('Product not found', { status: 404 });
  }

  // Track click
  const referrer = request.headers.get('referer');
  const userAgent = request.headers.get('user-agent');
  const country = request.headers.get('cf-ipcountry') || 'unknown';

  await db.trackClick({
    product_slug: slug,
    referrer,
    user_agent: userAgent,
    country
  });

  // Redirect to affiliate URL
  return redirect(product.affiliate_url, 302);
}