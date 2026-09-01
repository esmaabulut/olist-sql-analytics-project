-- ===================================================
-- Ranking Analysis
-- Purpose: Identify the highest- and lowest-selling categories
-- ===================================================

-- Top 5 categories by sales
SELECT TOP 5 p.product_category_name, 
       ROUND(SUM(o.price + o.freight_value), 2) AS TotalSales
FROM dbo.olist_order_items_dataset o
LEFT JOIN dbo.olist_products_dataset p 
ON o.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY TotalSales DESC;

-- Bottom 5 categories by sales
SELECT TOP 5 p.product_category_name, 
       ROUND(SUM(o.price + o.freight_value), 2) AS TotalSales
FROM dbo.olist_order_items_dataset o
LEFT JOIN dbo.olist_products_dataset p 
ON o.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY TotalSales ASC;
