-- ===================================================
-- Performance Analysis
-- Amaç: Ay-öncesi ile karşılaştırma (Month-over-Month değişim)
-- ===================================================

SELECT
    *,
    LAG(TotalSales) OVER(ORDER BY month) AS lagMonth,
    TotalSales - LAG(TotalSales) OVER(ORDER BY month) AS monthOverMonthChange,
    ROUND(
        (TotalSales - LAG(TotalSales) OVER(ORDER BY month)) 
        / LAG(TotalSales) OVER(ORDER BY month) * 100, 2
    ) AS pctChange
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
