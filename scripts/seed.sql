-- Seed sample products for cuan.ninja
-- Run with: npx wrangler d1 execute cuan-db --local --file=scripts/seed.sql

INSERT OR IGNORE INTO products (id, slug, name, description, affiliate_url, image_url, category) VALUES
(
  '550e8400-e29b-41d4-a716-446655440001',
  'notion-template-second-brain',
  'Notion Second Brain Template',
  'Sistem manajemen pengetahuan lengkap berbasis metodologi PARA. Termasuk database untuk Projects, Areas, Resources, Archives, serta template daily/weekly review.',
  'https://example.com/affiliate/notion-second-brain',
  'https://images.unsplash.com/photo-1611162617474-5b21e879e113?w=800',
  'Productivity'
),
(
  '550e8400-e29b-41d4-a716-446655440002',
  'saas-boilerplate-nextjs',
  'SaaS Boilerplate Next.js + Supabase',
  'Starter kit production-ready dengan Auth, Billing (Stripe), Dashboard, Team management, dan Email. Hemat 40+ jam development.',
  'https://example.com/affiliate/saas-boilerplate',
  'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800',
  'Developer Tools'
),
(
  '550e8400-e29b-41d4-a716-446655440003',
  'figma-design-system-kit',
  'Figma Design System Kit',
  'Komponen UI lengkap (300+), tokens, dokumentasi, dan guidelines. Cocok untuk tim produk yang butuh konsistensi visual cepat.',
  'https://example.com/affiliate/figma-ds',
  'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800',
  'Design'
),
(
  '550e8400-e29b-41d4-a716-446655440004',
  'ai-content-automation-course',
  'AI Content Automation Masterclass',
  'Belajar membangun pipeline konten otomatis: ideasi → riset → drafting → editing → publishing. Menggunakan n8n, Make, dan OpenAI API.',
  'https://example.com/affiliate/ai-content-course',
  'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800',
  'Course'
),
(
  '550e8400-e29b-41d4-a716-446655440005',
  'notion-life-os',
  'Notion Life OS Dashboard',
  'All-in-one life management: goals, habits, finances, health, learning, relationships. Dilengkapi template review bulanan & tahunan.',
  'https://example.com/affiliate/notion-life-os',
  'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=800',
  'Productivity'
),
(
  '550e8400-e29b-41d4-a716-446655440006',
  'react-email-templates',
  'React Email Template Collection',
  '50+ template email transaksional & marketing responsif. Kompatibel React Email, MJML, dan plain HTML. Termasuk dark mode.',
  'https://example.com/affiliate/react-email',
  'https://images.unsplash.com/photo-1586717791821-3f44a563fa4c?w=800',
  '["Developer Tools","Email","Marketing"]'
);