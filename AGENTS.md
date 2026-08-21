# Cuan.ninja — Agent Context & Memory

This file is the persistent memory for the cuan.ninja project. Read it at the start of every session before working. It is the source of truth for architecture, history, gotchas, and next steps.

## What this project is

- Affiliate catalog for curated digital products (templates, boilerplates, courses, tools) for developers & creators.
- Stack: Astro (SSR) + Tailwind CSS v4, deployed on Cloudflare (Workers via `@astrojs/cloudflare`, `output: 'server'`), database Cloudflare D1.
- Live site: https://cuan.ninja (Cloudflare). Repo: `syahrulmail/cuan-ninja` (branch `main`).

## Architecture

- `src/pages/index.astro` — catalog homepage (dark theme): hero + stats, sticky search, multi-label filter chips, product grid, empty state, how-it-works, footer. **Product detail modal**: clicking a card opens a modal with a 6-media slideshow (1 YouTube video via Plyr custom player + up to 5 images), title, full description, and a "Lihat Halaman Lengkap" button.
- `src/pages/go/[slug].js` — redirect engine: look up product by slug → track click → 302 to `affiliate_url`. Invalid slug → 404. Used by the modal's "Lihat Halaman Lengkap" button.
- `src/pages/api/click/[slug].js` — POST endpoint that records a click WITHOUT redirecting. Called when the product modal opens (so modal-open counts as a click, per product requirement).
- `src/lib/db.ts` — `Database` class wrapping D1 (`products`, `clicks` CRUD + stats). Helper `createDatabase(db)`.
- `src/layouts/Layout.astro` — base layout: SEO/OG/Twitter/canonical meta, Inter + Plus Jakarta Sans fonts.
- `src/styles/global.css` — Tailwind v4 theme (`@theme`) + components + utilities + `float-slow` keyframes + Plyr dark-theme overrides + modal/slideshow classes.
- `schema.sql` — D1 schema: `products` (incl. `video_url`, `images` JSON), `clicks`, trigger `increment_click_count`.
- `scripts/migrate_media.sql` — ALTER TABLE to add `video_url` + `images` to existing DBs (needed for DBs created before the modal feature).
- `scripts/seed.sql` — seed data (6 sample products with placeholder `video_url` + 5 `images` each). `scripts/seed.js` — generates same SQL to stdout for piping to wrangler.
- `wrangler.toml` — D1 binding `cuan_db` → database `cuan-db` (id `35d394e1-a613-4c05-9e20-5fc1430c9a08`).
- `astro.config.mjs` — `@astrojs/cloudflare` adapter + `@tailwindcss/vite` plugin.

## Key commands

```sh
npm install                 # Node >= 22.12 required (engines)
npm run build               # output: dist/
```

Local run (D1 local + wrangler dev — use a background terminal):

```sh
npx wrangler d1 create cuan-db --local
npx wrangler d1 execute cuan-db --local --file=schema.sql
npx wrangler d1 execute cuan-db --local --file=scripts/seed.sql
npx wrangler d1 execute cuan-db --local --file=scripts/migrate_media.sql   # only if DB predates the media columns
npx wrangler dev --local    # then hit http://localhost:8788
```

Deploy to Cloudflare:

```sh
npx wrangler login          # or export CLOUDFLARE_API_TOKEN
npx wrangler d1 execute cuan-db --remote --file=schema.sql
npx wrangler d1 execute cuan-db --remote --file=scripts/seed.sql
npx wrangler d1 execute cuan-db --remote --file=scripts/migrate_media.sql   # only if remote DB predates the media columns
npx wrangler deploy
```

## Critical gotchas & lessons learned

1. **Astro >= 6 removed `Astro.locals.runtime.env`.** Access bindings ONLY via `import { env } from 'cloudflare:workers'` (e.g. `env.cuan_db`). Do NOT reintroduce `locals.runtime` — it throws at runtime.
2. **`global.css` must be imported in Layout.astro frontmatter** (`import '../styles/global.css';`), NOT inside a `<script is:inline>` tag — the inline-script version is a syntax error in the browser and silently drops all styles.
3. **Multi-label categories:** `products.category` holds either one label OR a JSON array string (e.g. `["Developer Tools","Email","Marketing"]`). `index.astro` `parseLabels()` handles both; keep that compatibility.
4. **`wrangler` is NOT authenticated in the dev environment** (`wrangler whoami` → not authenticated). Any deploy must be done by the user (`npx wrangler login`) or with `CLOUDFLARE_API_TOKEN`; otherwise only local (`--local`) verification is possible from here.
5. **The GitHub repo once lagged behind the live build.** `https://cuan.ninja` HTML/CSS is the design reference; the repo is the source of truth going forward. If they diverge again, reconcile before editing.
6. **Do not re-seed the remote D1 blindly.** The production DB holds real click data (e.g. react-email-templates ~21 klik, total ~69) and multi-label categories already. `INSERT OR IGNORE` is safe; a fresh wipe would destroy stats.
7. **Astro CSRF protection:** POST requests to API endpoints WITHOUT a JSON `Content-Type` (or Origin header) get a hard `403 Cross-site POST form submissions are forbidden`. When calling `POST /api/click/{slug}` from the client, always send `headers: { 'Content-Type': 'application/json' }` (+ a JSON body).
8. **Media fields:** `products.video_url` is a YouTube URL; `products.images` is a JSON array string of up to 5 image URLs. The modal slideshow = 1 video (Plyr, YouTube IFrame provider with custom UI) + up to 5 images. `parseImages()`/`buildSlides()` handle JSON parsing; keep that compatibility.
9. **Plyr** (`plyr` npm package) is used for the video player; its CSS is imported in `global.css` (`@import "plyr/dist/plyr.css"`) and overridden for the dark theme. The video embed is rendered client-side (`data-plyr-provider="youtube"` + `data-plyr-embed-id`); Plyr loads the YouTube IFrame API automatically.
10. Local git identity must be set (env has none): `git config user.name "SyahrulMail"` / `git config user.email "dev@berbagi.or.id"`.

## History (recent work)

- *(next)* — Product detail modal feature (this work is pending commit).
- `99c17c1` — Rebuilt homepage to match the live design and fixed the Astro 7 D1 binding:
  - Switched all DB access to `cloudflare:workers` env.
  - Reconstructed navbar, hero + stats, sticky search + multi-label chips, product grid, empty state, how-it-works, footer.
  - Rebuilt `global.css` theme (`#05050a` bg, accent `#6366f1`→`#8b5cf6`, gold `#f0b65c`, Plus Jakarta Sans).
  - Added SEO/OG/Twitter/canonical meta; fixed the broken inline CSS import.
  - Multi-label seed for react-email-templates; brand favicon; full README.
  - Verified locally: homepage 200, `/go/{slug}` → 302 + click tracked + `click_count` increments, invalid slug → 404.
- `47262ef` and earlier — initial catalog + D1 + redirect engine (older, pre-rebuild).

## Current state & next steps

- Done: homepage parity with live; repo builds clean; verified locally end-to-end.
- In progress: product detail modal (slideshow video + images, tracking on open). **One real product seeded: DripSender** (`dripsender`, affiliate `https://dripsender.id`, video `youtu.be/b9fDIP9B2wg`, 5 webp images from dripsender.id, label "Email Marketing"). The other 5 products still use placeholder media (`video_url` + `images`) — the user will supply real data; replace in `scripts/seed.sql` + remote D1 via UPDATE (do NOT delete existing rows).
- **Deploy pending** — the rebuilt code is committed but NOT yet deployed to Cloudflare (needs wrangler auth from the user).
- Backlog (optional):
  - Admin CRUD to add/edit/delete products without SQL.
  - Per-category listing pages.
  - Sitemap / structured data (Product schema) for SEO.

## Working location & persistence

- Local clone: `/tmp/opencode/cuan-ninja` (may be re-created; git remote on GitHub is the durable store).
- Credentials: FTP/hosting credentials are for the berbagi.or.id project only and do NOT apply here. cuan.ninja uses Cloudflare — credentials live with the user's Cloudflare account, not in this repo.
