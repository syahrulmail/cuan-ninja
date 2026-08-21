-- Seed sample products for cuan.ninja
-- Run with: npx wrangler d1 execute cuan-db --local --file=scripts/seed.sql
-- Note: video_url/images di bawah ini placeholder. Ganti dengan data produk asli.

INSERT OR IGNORE INTO products (id, slug, name, description, affiliate_url, image_url, category, video_url, images) VALUES
(
  '550e8400-e29b-41d4-a716-446655440001',
  'notion-template-second-brain',
  'Notion Second Brain Template',
  'Sistem manajemen pengetahuan lengkap berbasis metodologi PARA. Termasuk database untuk Projects, Areas, Resources, Archives, serta template daily/weekly review. Cocok untuk pelajar, profesional, maupun kreator yang ingin merapikan seluruh catatan dan referensi dalam satu tempat.',
  'https://example.com/affiliate/notion-second-brain',
  'https://images.unsplash.com/photo-1611162617474-5b21e879e113?w=800',
  'Productivity',
  'https://www.youtube.com/watch?v=aqz-KE-bpKQ',
  '["https://images.unsplash.com/photo-1456324462728-c7d5e3c0c9b4?w=800","https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800","https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800","https://images.unsplash.com/photo-1506784983877-45594efa4cbe?w=800","https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=800"]'
),
(
  '550e8400-e29b-41d4-a716-446655440002',
  'saas-boilerplate-nextjs',
  'SaaS Boilerplate Next.js + Supabase',
  'Starter kit production-ready dengan Auth, Billing (Stripe), Dashboard, Team management, dan Email. Hemat 40+ jam development. Termasuk dokumentasi lengkap, contoh integrasi, dan best-practice arsitektur untuk produk SaaS modern.',
  'https://example.com/affiliate/saas-boilerplate',
  'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800',
  'Developer Tools',
  'https://www.youtube.com/watch?v=aqz-KE-bpKQ',
  '["https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=800","https://images.unsplash.com/photo-1517180102446-f3ece451e9d8?w=800","https://images.unsplash.com/photo-1522252234503-e356532cafd5?w=800","https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=800","https://images.unsplash.com/photo-1531482615713-2afd69097998?w=800"]'
),
(
  '550e8400-e29b-41d4-a716-446655440003',
  'figma-design-system-kit',
  'Figma Design System Kit',
  'Komponen UI lengkap (300+), tokens, dokumentasi, dan guidelines. Cocok untuk tim produk yang butuh konsistensi visual cepat. Termasuk dark & light mode, ikon, dan contoh halaman siap pakai.',
  'https://example.com/affiliate/figma-ds',
  'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800',
  'Design',
  'https://www.youtube.com/watch?v=aqz-KE-bpKQ',
  '["https://images.unsplash.com/photo-1581291518857-4e27b48ff24e?w=800","https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800","https://images.unsplash.com/photo-1613909207039-6b173b755cc1?w=800","https://images.unsplash.com/photo-1545235617-9465d2a55698?w=800","https://images.unsplash.com/photo-1547658719-da2b51169166?w=800"]'
),
(
  '550e8400-e29b-41d4-a716-446655440004',
  'ai-content-automation-course',
  'AI Content Automation Masterclass',
  'Belajar membangun pipeline konten otomatis: ideasi → riset → drafting → editing → publishing. Menggunakan n8n, Make, dan OpenAI API. Dilengkapi studi kasus nyata, prompt library, dan akses komunitas.',
  'https://example.com/affiliate/ai-content-course',
  'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800',
  'Course',
  'https://www.youtube.com/watch?v=aqz-KE-bpKQ',
  '["https://images.unsplash.com/photo-1620712943543-bcc4688e7485?w=800","https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=800","https://images.unsplash.com/photo-1518770660439-4636190af475?w=800","https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800","https://images.unsplash.com/photo-1535378917042-10a22c95931a?w=800"]'
),
(
  '550e8400-e29b-41d4-a716-446655440005',
  'notion-life-os',
  'Notion Life OS Dashboard',
  'All-in-one life management: goals, habits, finances, health, learning, relationships. Dilengkapi template review bulanan & tahunan. Bangun rutinitas dan kelola seluruh aspek hidupmu dalam satu workspace yang terstruktur.',
  'https://example.com/affiliate/notion-life-os',
  'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=800',
  'Productivity',
  'https://www.youtube.com/watch?v=aqz-KE-bpKQ',
  '["https://images.unsplash.com/photo-1519834785169-98be25ec3f84?w=800","https://images.unsplash.com/photo-1522199755839-a2bacb67c546?w=800","https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=800","https://images.unsplash.com/photo-1507925921958-8a62f3d1a50d?w=800","https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=800"]'
),
(
  '550e8400-e29b-41d4-a716-446655440006',
  'react-email-templates',
  'React Email Template Collection',
  '50+ template email transaksional & marketing responsif. Kompatibel React Email, MJML, dan plain HTML. Termasuk dark mode, preview live, dan dokumentasi customisasi.',
  'https://example.com/affiliate/react-email',
  'https://images.unsplash.com/photo-1586717791821-3f44a563fa4c?w=800',
  '["Developer Tools","Email","Marketing"]',
  'https://www.youtube.com/watch?v=aqz-KE-bpKQ',
  '["https://images.unsplash.com/photo-1557200134-90327ee9fafa?w=800","https://images.unsplash.com/photo-1516387938699-a93567ec168e?w=800","https://images.unsplash.com/photo-1586282391129-76a6df230234?w=800","https://images.unsplash.com/photo-1596526131083-e8c633c948d2?w=800","https://images.unsplash.com/photo-1614064641938-3bbee52942c7?w=800"]'
);
