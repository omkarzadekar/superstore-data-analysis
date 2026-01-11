---Bussiness questions to solve are below
---1) Top profit giving customers

select customer_name,
round(sum(total_profit),2) as total_profit
from aggregated_sample_superstore
group by customer_name
order by total_profit desc
limit 5;

2) Which products drive profit for our top customers? 

SELECT
    a.product_name,
    ROUND(SUM(a.total_profit)) AS product_profit
FROM aggregated_sample_superstore a
JOIN (
    SELECT customer_name
    FROM aggregated_sample_superstore
    GROUP BY customer_name
    ORDER BY SUM(total_profit) DESC
    LIMIT 5
) t
ON a.customer_name = t.customer_name
GROUP BY a.product_name
ORDER BY product_profit DESC
LIMIT 5;


--- 3) Top Product Profit Contribution by Category & Region

SELECT 
    a.category, 
    a.region, 
    a.product_name,
    ROUND(SUM(a.total_profit)) AS total_profit
FROM aggregated_sample_superstore a
join (
    SELECT product_name
    FROM aggregated_sample_superstore
    GROUP BY product_name
    ORDER BY SUM(total_profit) DESC
    limit 10
  ) b
on a.product_name = b.product_name
GROUP BY a.category, a.region, a.product_name
ORDER BY total_profit DESC
LIMIT 10;


--- 4) Average Shipping Time vs Product Profitability

SELECT
    product_name,
    region,
    AVG(DATEDIFF(ship_date, order_date)) AS avg_ship_days,
    round(sum(profit),2) AS total_profit
FROM sample_superstore
GROUP BY product_name,region
ORDER BY total_profit DESC
limit 10;

--- 5) Which categories are suffering losses due to high discounts?

SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(discount), 2) AS avg_discount,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin
FROM sample_superstore
GROUP BY category
ORDER BY total_profit ASC;
