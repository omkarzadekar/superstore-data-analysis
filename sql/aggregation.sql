---Created a view to save result in a view format so we can access it during analysis
create or replace view aggregated_sample_superstore as
SELECT
order_id,product_id,customer_name,segment,country,city,state,region,category,sub_category,product_name,
round(sum(sales),2) as total_sales,avg(discount) as avg_discount,round(sum(profit),2) as total_profit ,Min(order_date) as min_order_date,Max(ship_date) as max_ship_date
from sample_superstore
group by
order_id,product_id,customer_name,segment,country,city,state,region,category,sub_category,product_name;

select * from aggregated_sample_superstore;
