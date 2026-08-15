// Seed sample products into D1
import { createDatabase } from './src/lib/db.js';

const sampleProducts = [
  {
    slug: 'notion-template-second-brain',
    name: 'Notion Second Brain Template',
    description: 'Sistem manajemen pengetahuan lengkap berbasis metodologi PARA. Termasuk database untuk Projects, Areas, Resources, Archives, serta template daily/weekly review.',
    affiliate_url: 'https://example.com/affiliate/notion-second-brain',
    image_url: 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?w=800',
    category: 'Productivity'
  },
  {
    slug: 'saas-boilerplate-nextjs',
    name: 'SaaS Boilerplate Next.js + Supabase',
    description: 'Starter kit production-ready dengan Auth, Billing (Stripe), Dashboard, Team management, dan Email. Hemat 40+ jam development.',
    affiliate_url: 'https://example.com/affiliate/saas-boilerplate',
    image_url: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800',
    category: 'Developer Tools'
  },
  {
    slug: 'figma-design-system-kit',
    name: 'Figma Design System Kit',
    description: 'Komponen UI lengkap (300+), tokens, dokumentasi, dan guidelines. Cocok untuk tim produk yang butuh konsistensi visual cepat.',
    affiliate_url: 'https://example.com/affiliate/figma-ds',
    image_url: 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800',
    category: 'Design'
  },
  {
    slug: 'ai-content-automation-course',
    name: 'AI Content Automation Masterclass',
    description: 'Belajar membangun pipeline konten otomatis: ideasi → riset → drafting → editing → publishing. Menggunakan n8n, Make, dan OpenAI API.',
    affiliate_url: 'https://example.com/affiliate/ai-content-course',
    image_url: 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800',
    category: 'Course'
  },
  {
    slug: 'notion-life-os',
    name: 'Notion Life OS Dashboard',
    description: 'All-in-one life management: goals, habits, finances, health, learning, relationships. Dilengkapi template review bulanan & tahunan.',
    affiliate_url: 'https://example.com/affiliate/notion-life-os',
    image_url: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=800',
    category: 'Productivity'
  },
  {
    slug: 'react-email-templates',
    name: 'React Email Template Collection',
    description: '50+ template email transaksional & marketing responsif. Kompatibel React Email, MJML, dan plain HTML. Termasuk dark mode.',
    affiliate_url: 'https://example.com/affiliate/react-email',
    image_url: 'https://images.unsplash.com/photo-1586717791821-3f44a563fa4c?w=800',
    category: 'Developer Tools'
  }
];

async function seed() {
  // We need to simulate the D1 binding for local execution
  // This will be run via wrangler locally
  console.log('Seeding products...');
  
  // This is a reference script - actual execution needs wrangler
  for (const product of sampleProducts) {
    console.log(`Would insert: ${product.name} (${product.slug})`);
  }
  
  console.log('\nTo actually seed, run:');
  console.log('npx wrangler d1 execute cuan-db --local --command="..."');
  console.log('Or create a Worker script to do this programmatically.');
}

seed();