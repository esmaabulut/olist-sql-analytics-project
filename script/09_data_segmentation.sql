-- ===================================================
-- Data Segmentation
-- Purpose: Segment customers into Low/Mid/High-Value tiers based on total spending
-- ===================================================

select t.customer_id, sum(o.freight_value+o.price) TotalSales, 
case 
	when sum(o.freight_value+o.price) < 5000 then 'Low-Value' 
	when sum(o.freight_value+o.price) between 5000 and 10000 then 'Mid-Value' 
	when sum(o.freight_value+o.price) > 10000 then 'High-Value' 
	else 'UNKNOWN' 
end CustomerSegment 
from dbo.olist_order_items_dataset o 
left join dbo.olist_orders_dataset t on o.order_id = t.order_id 
group by t.customer_id
