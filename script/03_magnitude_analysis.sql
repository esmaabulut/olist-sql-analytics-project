-- ===================================================
-- Magnitude Analysis
-- Amaç: Bir measure'ı bir dimension'a göre kırılım yaparak incelemek
-- ===================================================

-- Ürün kategorisine göre ortalama fiyat
SELECT
    p.product_category_name,
    ROUND(AVG(o.price), 2) AS avgPrice
FROM dbo.olist_order_items_dataset o
LEFT JOIN dbo.olist_products_dataset p
    ON o.product_id = p.product_id
GROUP BY p.product_category_name;

-- Şehre göre ortalama teslimat süresi (gün)
SELECT 
    c.customer_city,
    AVG(DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date)) AS avgDelivered
FROM dbo.olist_orders_dataset o 
LEFT JOIN dbo.olist_customers_dataset c
    ON o.customer_id = c.customer_id
WHERE DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date) IS NOT NULL
GROUP BY c.customer_city
ORDER BY avgDelivered DESC;

-- Kategoriye göre toplam satış tutarı
SELECT
    p.product_category_name,
    ROUND(SUM(o.price + o.freight_value), 2) AS TotalSales
FROM dbo.olist_order_items_dataset o
LEFT JOIN dbo.olist_products_dataset p
    ON o.product_id = p.product_id
GROUP BY p.product_category_name;
