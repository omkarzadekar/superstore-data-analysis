-- Business KPI's

--1) How many unique customers placed at least one order

select count(distinct customer_key) as total_customers
from fact_sales;

--2)Total revenue per customer

select c.customer_id,
c.customer_name,
round(sum(f.sales),2) as total_revenue
from fact_sales f
join dim_customers c
on f.customer_key = c.customer_key
group by customer_id, customer_name
order by total_revenue desc;

--3) Top 10 customers by revenue

select c.customer_id,
c.customer_name,
round(sum(f.sales),2) as total_revenue
from fact_sales f
join dim_customers c
on f.customer_key = c.customer_key
group by customer_id, customer_name
order by total_revenue desc
limit 10;

--4) Total profit per customer

select c.customer_id,
c.customer_name,
round(sum(f.profit),2) as total_profit
from fact_sales f
join dim_customers c
on f.customer_key = c.customer_key
group by c.customer_id,c.customer_name
order by total_profit desc;

--5) Average order value (AOV) per customer

select c.customer_id,
c.customer_name,
round(sum(f.sales)/count(distinct order_id),2) as avg_order_value
from fact_sales f
join dim_customers c
on f.customer_key = c.customer_key
group by customer_id, customer_name
order by avg_order_value desc;

-- 6) Repeat customers vs one-time customers

select 
case
	when order_count = 1 then 'one-time customers'
    else 'repeat customers'
end as customer_type,
count(*) as customer_count
from (
select customer_key,
count(distinct order_id) as order_count
from fact_sales
group by customer_key
) t
group by customer_type;

-- customer order frequency

WITH customer_orders AS (
    SELECT 
        customer_key,
        COUNT(DISTINCT order_id) AS order_count
    FROM fact_sales
    GROUP BY customer_key
)
SELECT 
    CASE 
        WHEN order_count = 1 THEN 'One-time'
        WHEN order_count BETWEEN 2 AND 5 THEN 'Occasional'
        ELSE 'Frequent'
    END AS customer_type,
    COUNT(*) AS customers
FROM customer_orders
GROUP BY customer_type;

--7) Revenue contribution by costomer segment

select c.segment,
round(sum(f.sales),2) as total_revenue
from fact_sales f
join dim_customers c
on f.customer_key = c.customer_key
group by c.segment
order by total_revenue desc;

-- 8)How many unique products generated sales

select count(distinct product_key) as total_products
from fact_sales;

-- 9)Revenue by product

select p.product_id,
p.product_name,
round(sum(f.sales),2) as total_revenue
from fact_sales f
join dim_products p
on f.product_key = p.product_key
group by p.product_id, p.product_name
order by total_revenue desc;

-- 10) Top 10 products by revenue

select p.product_id,
p.product_name,
round(sum(f.sales),2) as total_revenue
from fact_sales f
join dim_products p
on f.product_key = p.product_key
group by p.product_id, p.product_name
order by total_revenue desc
limit 10;

-- 11) Top 3 products per category
-- using window functions, subquery

select *
from (
select p.category,
p.product_name,
round(sum(f.sales),2) as revenue,
dense_rank() over(partition by p.category order by round(sum(f.sales),2) desc)as product_rank
from fact_sales f
join dim_products p
on f.product_key = p.product_key
group by p.category,p.product_name) t
where product_rank <= 3;

-- 12) Customers contributing to 80% of Revenue
-- subquery + running total - Pareto / 80-20 rule

select customer_id, customer_name,revenue,revenue_ratio
from(
select
c.customer_id,
c.customer_name,
sum(f.sales) as revenue,
sum(sum(f.sales)) over() as total_revenue,
round(sum(sum(f.sales)) over (
order by sum(f.sales) desc
)/sum(sum(f.sales)) over(),2) as revenue_ratio
from fact_sales f
join dim_customers c
on f.customer_key = c.customer_key
group by c.customer_id, c.customer_name
) t
where revenue_ratio <= 0.8;

-- 13) Month-over-month revenue growth

select
year,
month,
round(
(revenue - lag(revenue) over(order by year,month)) /
nullif(lag(revenue) over(order by year,month),0)*100
,2) as mom_growth_percentage
from(
select
d.year,
d.month,
sum(f.sales) as revenue
from fact_sales f
join dim_date d
on d.date_key = f.order_date_key
group by d.year, d.month
) t;

-- 14) Hightest revenue customer per region

select *
from(
select 
g.region,
c.customer_name,
round(sum(f.sales),2) as revenue,
rank () over(partition by g.region order by round(sum(f.sales),2) desc) as region_rank
from fact_sales f
join dim_customers c
on f.customer_key = c.customer_key
join dim_geography g
on f.geography_key = g.geography_key
group by g.region, c.customer_name
) t
where region_rank = 1;

-- 15) Product with negative profit

select 
p.product_name,
round(sum(f.profit),2) as total_profit
from fact_sales f
join dim_products p
on f.product_key = p.product_key
group by p.product_name
having sum(f.profit) < 0;

-- 16) Customer life time values

select
customer_id,
customer_name,
round(total_revenue,2) as lifetime_value
from(
select
c.customer_id,
c.customer_name,
sum(f.sales) as total_revenue
from fact_sales f
join dim_customers c
on f.customer_key = c.customer_key
group by c.customer_id,c.customer_name
) t
order by lifetime_value desc;

-- 17) Revenue contribution % by category

select category,
round( revenue / sum(revenue) over() *100,2) as contribution_percentage
from(
select 
p.category,
sum(f.sales) as revenue
from fact_sales f
join dim_products p
on f.product_key = p.product_key
group by p.category
) t
order by contribution_percentage desc;



