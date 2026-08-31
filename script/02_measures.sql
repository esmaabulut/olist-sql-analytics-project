-- ===================================================
-- Measures
-- Amaç: Dimension'a bağlı olmadan genel özet (büyük) sayıları hesaplamak
-- ===================================================

-- Toplam sipariş sayısı
SELECT COUNT(DISTINCT order_id) AS totalOrder 
FROM dbo.olist_orders_dataset;

-- Ortalama ürün fiyatı
SELECT ROUND(AVG(price), 2) AS avgPrice  
FROM dbo.olist_order_items_dataset;

-- Ortalama kargo ücreti
SELECT ROUND(AVG(freight_value), 2) AS avgFreight 
FROM dbo.olist_order_items_dataset;

-- Toplam farklı ürün sayısı
SELECT COUNT(DISTINCT product_id) AS totalProduct 
FROM dbo.olist_products_dataset;

-- Toplam farklı kategori sayısı
SELECT COUNT(DISTINCT product_category_name) AS totalCategory 
FROM dbo.olist_products_dataset;

-- Toplam müşteri sayısı
SELECT COUNT(DISTINCT customer_id) AS totalCustomer 
FROM dbo.olist_customers_dataset;

-- Toplam farklı şehir sayısı
SELECT COUNT(DISTINCT customer_city) AS totalCity 
FROM dbo.olist_customers_dataset;
