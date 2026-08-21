interface Product {
  id: string;
  slug: string;
  name: string;
  description: string | null;
  affiliate_url: string;
  image_url: string | null;
  category: string | null;
  video_url: string | null;
  images: string | null;
  click_count: number;
  created_at: string;
  updated_at: string;
}

interface ClickData {
  product_slug: string;
  referrer: string | null;
  user_agent: string | null;
  country: string | null;
}

export class Database {
  private db: D1Database;

  constructor(db: D1Database) {
    this.db = db;
  }

  // Get all products (for catalog listing)
  async getAllProducts(): Promise<Product[]> {
    const result = await this.db
      .prepare('SELECT * FROM products ORDER BY created_at DESC')
      .all<Product>();
    return result.results || [];
  }

  // Get products by category
  async getProductsByCategory(category: string): Promise<Product[]> {
    const result = await this.db
      .prepare('SELECT * FROM products WHERE category = ? ORDER BY created_at DESC')
      .bind(category)
      .all<Product>();
    return result.results || [];
  }

  // Get product by slug (for detail page and redirection)
  async getProductBySlug(slug: string): Promise<Product | null> {
    const result = await this.db
      .prepare('SELECT * FROM products WHERE slug = ?')
      .bind(slug)
      .first<Product>();
    return result || null;
  }

  // Create new product
  async createProduct(
    product: Omit<Product, 'id' | 'click_count' | 'created_at' | 'updated_at'>
  ): Promise<Product> {
    const id = crypto.randomUUID();
    await this.db
      .prepare(`
        INSERT INTO products (id, slug, name, description, affiliate_url, image_url, category, video_url, images)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      `)
      .bind(
        id,
        product.slug,
        product.name,
        product.description,
        product.affiliate_url,
        product.image_url,
        product.category,
        product.video_url,
        product.images
      )
      .run();

    return this.getProductBySlug(product.slug) as Promise<Product>;
  }

  // Update product
  async updateProduct(slug: string, updates: Partial<Product>): Promise<Product | null> {
    const fields = Object.keys(updates).filter(key => key !== 'id' && key !== 'slug' && key !== 'created_at');
    if (fields.length === 0) return this.getProductBySlug(slug);
    
    const setClause = fields.map(field => `${field} = ?`).join(', ');
    const values = fields.map(field => updates[field as keyof Product]);
    
    await this.db
      .prepare(`UPDATE products SET ${setClause}, updated_at = CURRENT_TIMESTAMP WHERE slug = ?`)
      .bind(...values, slug)
      .run();
    
    return this.getProductBySlug(slug);
  }

  // Delete product
  async deleteProduct(slug: string): Promise<boolean> {
    const result = await this.db
      .prepare('DELETE FROM products WHERE slug = ?')
      .bind(slug)
      .run();
    return result.changes > 0;
  }

  // Track click
  async trackClick(data: ClickData): Promise<void> {
    await this.db
      .prepare(`
        INSERT INTO clicks (product_slug, referrer, user_agent, country)
        VALUES (?, ?, ?, ?)
      `)
      .bind(data.product_slug, data.referrer, data.user_agent, data.country)
      .run();
  }

  // Get click stats for a product
  async getClickStats(slug: string, days: number = 30): Promise<number> {
    const result = await this.db
      .prepare(`
        SELECT COUNT(*) as count 
        FROM clicks 
        WHERE product_slug = ? AND clicked_at > datetime('now', ?)
      `)
      .bind(slug, `-${days} days`)
      .first<{ count: number }>();
    return result?.count || 0;
  }

  // Get all categories
  async getCategories(): Promise<string[]> {
    const result = await this.db
      .prepare('SELECT DISTINCT category FROM products WHERE category IS NOT NULL')
      .all<{ category: string }>();
    return result.results.map(r => r.category);
  }
}

// Helper to create database instance from Astro locals
export function createDatabase(db: D1Database): Database {
  return new Database(db);
}