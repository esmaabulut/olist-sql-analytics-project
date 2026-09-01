-- ===================================================
-- Customer Report
-- Purpose: Combine order count, spending, recency, and delivery time
-- for each customer into a single view
-- ===================================================

create view dbo.report_customer as

with base_query as(
	select
	i.order_id, i.price, i.freight_value,
	o.order_status, o.order_purchase_timestamp, o.order_delivered_customer_date,
	c.customer_unique_id, c.customer_city,
	p.product_category_name
	from dbo.olist_order_items_dataset i
	left join dbo.olist_orders_dataset o on i.order_id = o.order_id
	left join dbo.olist_customers_dataset c on o.customer_id = c.customer_id
	left join dbo.olist_products_dataset p on i.product_id = p.product_id
	where o.order_status = 'delivered'
)

,Aggregation AS (
    select
        customer_unique_id, customer_city,
        count(distinct order_id) AS TotalOrders,
        count(distinct product_category_name) AS TotalCategoriesPurchased,
        sum(price + freight_value) AS TotalSales,
        max(order_purchase_timestamp) AS lastOrder,
        avg(datediff(day, order_purchase_timestamp, order_delivered_customer_date)) AS AvgDeliveryTime
    from base_query
    group by customer_unique_id, customer_city
)

,FinalQuery as(
	select 
	customer_unique_id, customer_city, TotalCategoriesPurchased, lastOrder,
	TotalOrders, TotalSales,
	case 
		when TotalSales < 5000 then 'Low-Value'
		when TotalSales between 5000 and 10000 then 'Mid-Value'
		when TotalSales > 10000 then 'High-Value'
		else 'UNKNOWN'
	end CustomerSegment,
	datediff(day, lastOrder, GETDATE()) Recency,
	AvgDeliveryTime
	from Aggregation
)
select * from FinalQuery
