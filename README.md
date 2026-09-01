# Olist E-Commerce SQL Analytics Project

An end-to-end SQL analytics project built on the [Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce), covering exploratory data analysis, customer segmentation, and reporting using SQL Server.

## 📌 Business Problem

An e-commerce company wants to understand its sales performance, customer behavior, and delivery operations in order to:

- Identify which order statuses dominate the pipeline (delivered, canceled, shipped, etc.)
- Understand where sales volume concentrates across time, categories, and geography
- Segment customers by total spending to prioritize retention and marketing efforts
- Build a reusable customer-level report combining order frequency, spending, recency, and delivery performance

This project answers those questions purely through SQL, simulating the kind of exploratory and reporting work expected from a Data Analyst.

## 🗂️ Dataset

The [Olist dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) contains real, anonymized order data from a Brazilian marketplace (2016–2018). Tables used:

| Table | Description |
|---|---|
| `olist_orders_dataset` | One row per order, with status and timestamp milestones |
| `olist_order_items_dataset` | One row per item within an order (price, freight, product, seller) |
| `olist_customers_dataset` | Customer identity and location |
| `olist_products_dataset` | Product catalog and physical attributes |


## 🛠️ Tools

- **SQL Server / T-SQL** — all analysis and reporting logic
- **SSMS** — query development
- **Python (pandas, matplotlib, seaborn)** — visualizing SQL output

## 🧠 SQL Techniques Used

- Common Table Expressions (CTEs), including multi-layer chaining
- Window functions (`SUM() OVER()` for running totals)
- `JOIN`s across multiple relational tables
- Aggregate functions (`SUM`, `COUNT DISTINCT`, `AVG`, `MAX`)
- `CASE WHEN` for business-rule-based segmentation
- `DATEDIFF` / `DATETRUNC` for time-based metrics (recency, delivery time, trends)
- Part-to-whole (percentage) analysis
- View creation for reusable, production-style reporting

## 📊 Analysis Scripts

| Script | What it does |
|---|---|
| `01_dimension_exploration.sql` | Explores distinct values in key categorical columns (city, category, order status) |
| `02_measures.sql` | Establishes baseline metrics: total revenue, orders, quantity, customers, products |
| `03_magnitude_analysis.sql` | Breaks measures down by dimension (e.g. revenue by state or category) |
| `04_ranking_analysis.sql` | Ranks top/bottom performers (e.g. best-selling products, top customers) |
| `05_change_over_time.sql` | Monthly sales trend using `DATETRUNC` |
| `06_cumulative_analysis.sql` | Running total of monthly revenue using a window function |
| `07_performance_analysis.sql` | Compares each period/category against its own average or a benchmark |
| `08_part_to_whole_analysis.sql` | Percentage share of each order status relative to total orders |
| `09_data_segmentation.sql` | Segments customers into Low/Mid/High-Value tiers by total spending |
| `10_report_customers.sql` | Builds the final `dbo.report_customer` view (see below) |

## ⭐ Highlight: Customer Report View

The most complex piece of the project — a single reusable view combining order history, spending, category diversity, recency, and delivery performance per customer, layered through three CTEs (raw join → aggregation → final segmentation):

```sql
CREATE VIEW dbo.report_customer AS
WITH base_query AS (
    SELECT
        i.order_id, i.price, i.freight_value,
        o.order_status, o.order_purchase_timestamp, o.order_delivered_customer_date,
        c.customer_unique_id, c.customer_city,
        p.product_category_name
    FROM dbo.olist_order_items_dataset i
    LEFT JOIN dbo.olist_orders_dataset o ON i.order_id = o.order_id
    LEFT JOIN dbo.olist_customers_dataset c ON o.customer_id = c.customer_id
    LEFT JOIN dbo.olist_products_dataset p ON i.product_id = p.product_id
    WHERE o.order_status = 'delivered'
),
Aggregation AS (
    SELECT
        customer_unique_id, customer_city,
        COUNT(DISTINCT order_id) AS TotalOrders,
        COUNT(DISTINCT product_category_name) AS TotalCategoriesPurchased,
        SUM(price + freight_value) AS TotalSales,
        MAX(order_purchase_timestamp) AS lastOrder,
        AVG(DATEDIFF(DAY, order_purchase_timestamp, order_delivered_customer_date)) AS AvgDeliveryTime
    FROM base_query
    GROUP BY customer_unique_id, customer_city
)
SELECT
    customer_unique_id, customer_city, TotalCategoriesPurchased, lastOrder,
    TotalOrders, TotalSales,
    CASE
        WHEN TotalSales < 5000 THEN 'Low-Value'
        WHEN TotalSales BETWEEN 5000 AND 10000 THEN 'Mid-Value'
        WHEN TotalSales > 10000 THEN 'High-Value'
        ELSE 'UNKNOWN'
    END AS CustomerSegment,
    DATEDIFF(DAY, lastOrder, GETDATE()) AS Recency,
    AvgDeliveryTime
FROM Aggregation;
```

Full code for every script lives in `/sql/`.

## 🚀 How to Reproduce

1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
2. Import the CSVs into SQL Server (`BULK INSERT`, see `/sql/00_database_setup.sql`)
3. Run scripts in `/sql/` in numeric order (01 → 10)

## 📁 Repository Structure

```
📁 olist-sql-analytics
├── 📁 sql/
│   ├── 01_dimension_exploration.sql
│   ├── 02_measures.sql
│   ├── 03_magnitude_analysis.sql
│   ├── 04_ranking_analysis.sql
│   ├── 05_change_over_time.sql
│   ├── 06_cumulative_analysis.sql
│   ├── 07_performance_analysis.sql
│   ├── 08_part_to_whole_analysis.sql
│   ├── 09_data_segmentation.sql
│   └── 10_report_customers.sql
├── README.md
```

## 👤 Author

Esma Bulut — 3rd-year Data Science and Analytics student, working toward a career in Data Science.

[LinkedIn](https://www.linkedin.com/in/esma-bulut-0a3a05408/) 
