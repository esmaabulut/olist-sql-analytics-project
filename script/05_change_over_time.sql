-- ===================================================
-- Change Over Time
-- Purpose: Analyze monthly sales and order trends
-- ===================================================

-- Total monthly sales
SELECT DATETRUNC(month, o.order_purchase_timestamp) AS month, 
       ROUND(SUM(t.price + t.freight_value), 2) AS TotalSales
FROM dbo.olist_order_items_dataset t
LEFT JOIN dbo.olist_orders_dataset o 
ON t.order_id = o.order_id
GROUP BY DATETRUNC(month, o.order_purchase_timestamp)
ORDER BY DATETRUNC(month, o.order_purchase_timestamp);

-- Total monthly orders
SELECT DATETRUNC(month, order_purchase_timestamp) AS month, 
       COUNT(order_id) AS totalOrder
FROM dbo.olist_orders_dataset
GROUP BY DATETRUNC(month, order_purchase_timestamp)
ORDER BY DATETRUNC(month, order_purchase_timestamp);
