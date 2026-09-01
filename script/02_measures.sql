-- ===================================================
-- Measures
-- Purpose: Calculate general summary metrics independently of dimensions
-- ===================================================

-- Total number of orders
SELECT COUNT(DISTINCT order_id) AS totalOrder
FROM dbo.olist_orders_dataset;

-- Average product price
SELECT ROUND(AVG(price), 2) AS avgPrice
FROM dbo.olist_order_items_dataset;

-- Average freight cost
SELECT ROUND(AVG(freight_value), 2) AS avgFreight
FROM dbo.olist_order_items_dataset;

-- Total number of distinct products
SELECT COUNT(DISTINCT product_id) AS totalProduct
FROM dbo.olist_products_dataset;

-- Total number of distinct categories
SELECT COUNT(DISTINCT product_category_name) AS totalCategory
FROM dbo.olist_products_dataset;

-- Total number of customers
SELECT COUNT(DISTINCT customer_id) AS totalCustomer
FROM dbo.olist_customers_dataset;

-- Total number of distinct cities
SELECT COUNT(DISTINCT customer_city) AS totalCity
FROM dbo.olist_customers_dataset;
