-- ===================================================
-- Part-to-Whole Analysis
-- Purpose: Find each order status's percentage share of the total
-- ===================================================

select *, concat(round((cast(totalStatus as float)/cast(TotalOrder as float))*100,2),'%') OrderStatusRate 
from(
	select  
	order_status, 
	count(order_id) totalStatus, 
	(select count(order_id) from dbo.olist_orders_dataset) TotalOrder 
	from dbo.olist_orders_dataset 
	group by order_status
)t
