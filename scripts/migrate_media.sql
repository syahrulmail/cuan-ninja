-- Migration: add media columns (video + images slideshow) to existing D1 databases.
-- Run with: npx wrangler d1 execute cuan-db --local --file=scripts/migrate_media.sql
--            (or --remote for production)

ALTER TABLE products ADD COLUMN video_url TEXT;
ALTER TABLE products ADD COLUMN images TEXT;
