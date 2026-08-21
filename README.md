# Cuan.ninja

Katalog affiliate digital berteknologi Cloudflare. Menampilkan kurasi produk digital (template, boilerplate, course, tools) dengan mekanisme redirect ter-tracking.

- **Frontend**: Astro (SSR) + Tailwind CSS v4
- **Deploy**: Cloudflare Workers / Pages (`@astrojs/cloudflare`), `output: 'server'`
- **Database**: Cloudflare D1 (tabel `products` + `clicks`, trigger penghitung klik)

## Fitur

- Halaman katalog dark-theme: hero + statistik, sticky search, filter multi-label
- Redirect engine: `/go/{slug}` → lookup produk → catat klik → `302` ke `affiliate_url`
- Produk mendukung banyak label (contoh `["Developer Tools","Email","Marketing"]`)
- SEO meta (OG/Twitter/canonical), favicon brand, aksesibel (reduced-motion, keyboard `/`)

## Struktur

```text
/
├── public/
│   └── favicon.svg
├── scripts/
│   ├── seed.sql           # seed sample (jalankan via wrangler)
│   └── seed.js            # generator SQL yang sama, untuk pipa ke wrangler
├── src/
│   ├── layouts/Layout.astro
│   ├── lib/db.ts          # akses data D1 (produk, klik, kategori)
│   ├── pages/
│   │   ├── index.astro    # katalog utama
│   │   └── go/[slug].js   # redirect + tracking klik
│   └── styles/global.css  # tema Tailwind v4
├── schema.sql             # skema D1 (products, clicks, trigger)
├── astro.config.mjs
└── wrangler.toml          # binding D1 `cuan_db`
```

## Menjalankan Lokal

```sh
# Install dependencies
npm install

# Set up database lokal (wrangler --local)
npx wrangler d1 create cuan-db --local
npx wrangler d1 execute cuan-db --local --file=schema.sql
npx wrangler d1 execute cuan-db --local --file=scripts/seed.sql

# Jalankan dev server (rekomendasi: background mode)
npx wrangler dev --local
```

## Build

```sh
npm run build
```

Output ada di `dist/`. Karena `output: 'server'`, halaman dirender oleh Worker saat runtime (butuh binding D1).

## Deploy ke Cloudflare

Prasyarat: login wrangler (`npx wrangler login`) atau `CLOUDFLARE_API_TOKEN`.

```sh
# Buat database D1 di remote
npx wrangler d1 create cuan-db
# Isi database_id di wrangler.toml dengan nilai dari output

# Seed data remote
npx wrangler d1 execute cuan-db --remote --file=schema.sql
npx wrangler d1 execute cuan-db --remote --file=scripts/seed.sql

# Deploy worker
npx wrangler deploy
```

Setelah deploy, hubungkan custom domain (mis. `cuan.ninja`) di dashboard Cloudflare → Workers Routes atau Pages Custom Domains.

## Data Model

`products`:

| kolom          | tipe      | catatan |
|----------------|-----------|---------|
| `id`           | TEXT (PK) | UUID    |
| `slug`         | TEXT (UNIQUE) | dipakai `/go/{slug}` |
| `name`         | TEXT      |         |
| `description`  | TEXT      |         |
| `affiliate_url`| TEXT      | tujuan redirect |
| `image_url`    | TEXT      |         |
| `category`     | TEXT      | 1 label atau JSON array label |
| `click_count`  | INTEGER   | di-increment trigger |
| `created_at` / `updated_at` | DATETIME | |

`clicks`: satu baris per klik (product_slug, referrer, user_agent, country, clicked_at). Trigger `increment_click_count` menaikkan `products.click_count` otomatis.
