-- ===================================================
-- Dimension Exploration
-- Amaç: Kategorik kolonlardaki farklı (distinct) değerleri keşfetmek
-- ===================================================

-- Müşterilerin şehir ve eyalet bilgileri
SELECT DISTINCT customer_city, customer_state
FROM dbo.olist_customers_dataset
ORDER BY 1, 2;

-- Ürün kategorileri
SELECT DISTINCT product_category_name
FROM dbo.olist_products_dataset;

-- Sipariş durumları (delivered, canceled, vs.)
SELECT DISTINCT order_status 
FROM dbo.olist_orders_dataset;
