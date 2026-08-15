-- cuan.ninja D1 Database Schema

-- Products table
CREATE TABLE IF NOT EXISTS products (
    id TEXT PRIMARY KEY,
    slug TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    affiliate_url TEXT NOT NULL,
    image_url TEXT,
    category TEXT,
    click_count INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Index for fast slug lookups (for redirection)
CREATE INDEX IF NOT EXISTS idx_products_slug ON products(slug);

-- Index for category filtering
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);

-- Clicks tracking table (optional - for detailed analytics)
CREATE TABLE IF NOT EXISTS clicks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_slug TEXT NOT NULL,
    referrer TEXT,
    user_agent TEXT,
    country TEXT,
    clicked_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_clicks_product_slug ON clicks(product_slug);
CREATE INDEX IF NOT EXISTS idx_clicks_clicked_at ON clicks(clicked_at);

-- Trigger to update product click_count
CREATE TRIGGER IF NOT EXISTS increment_click_count
AFTER INSERT ON clicks
BEGIN
    UPDATE products 
    SET click_count = click_count + 1,
        updated_at = CURRENT_TIMESTAMP
    WHERE slug = NEW.product_slug;
END;