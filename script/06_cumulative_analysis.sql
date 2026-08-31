-- ===================================================
-- Cumulative Analysis
-- Amaç: Running total (kümülatif toplam) ve moving average (hareketli ortalama)
-- ===================================================

-- Aylık running total (kümülatif satış)
SELECT
    *,
    SUM(TotalSales) OVER(ORDER BY month) AS runningTotal
FROM (
    SELECT
        DATETRUNC(month, o.order_purchase_timestamp) AS month,
        ROUND(SUM(t.price + t.freight_value), 2) AS TotalSales
    FROM dbo.olist_order_items_dataset t
    LEFT JOIN dbo.olist_orders_dataset o
        ON t.order_id = o.order_id
    GROUP BY DATETRUNC(month, o.order_purchase_timestamp)
) t
ORDER BY month;

-- Aylık moving average (hareketli ortalama satış)
SELECT
    *,
    AVG(avgSales) OVER(ORDER BY month) AS movingAvgSales
FROM (
    SELECT
        DATETRUNC(month, o.order_purchase_timestamp) AS month,
        AVG(t.price + t.freight_value) AS avgSales
    FROM dbo.olist_order_items_dataset t
    LEFT JOIN dbo.olist_orders_dataset o
        ON t.order_id = o.order_id
    GROUP BY DATETRUNC(month, o.order_purchase_timestamp)
) t
ORDER BY month;
