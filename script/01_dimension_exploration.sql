-- ===================================================
-- Dimension Exploration
-- Purpose: Explore distinct values in categorical columns
-- ===================================================

-- Customers' city and state information
SELECT DISTINCT customer_city, customer_state
FROM dbo.olist_customers_dataset
ORDER BY 1, 2;

-- Product categories
SELECT DISTINCT product_category_name
FROM dbo.olist_products_dataset;

-- Order statuses (delivered, canceled, etc.)
SELECT DISTINCT order_status
FROM dbo.olist_orders_dataset;
