--First Task was to check whether dataset has any duplicates rows or not
---Following query is correct but not efficient takes lots of time for execution
SELECT *
FROM sample_superstore
where (order_id, product_id) in (
select order_id,
product_id
from sample_superstore
group by order_id, product_id
having count(*) > 1);

---So to optimize above query, wrote new query that uses self join which runs quickly and efficently
select s.*
from sample_superstore as s
join
(
select order_id,
product_id
from sample_superstore
group by order_id, product_id
having count(*) > 1
) as d
on s.order_id = d.order_id
and s.product_id = d.product_id;


---Another query using cte to solve the same problem, to find if there are any duplicates or not
select *,
row_number() over(partition by row_id, order_date, ship_date, ship_mode, customer_id, customer_name, segment, country, city, state, region, product_id, category, sub_category, product_name, sales, quantity, discount, profit) as row_num
from sample_superstore;

with duplicate_cte as 
(
select *,
row_number() over(partition by row_id, order_date, ship_date, ship_mode, customer_id, customer_name, segment, country, city, state, region, product_id, category, sub_category, product_name, sales, quantity, discount, profit) as row_num
from sample_superstore
)
select *
from duplicate_cte
where row_num > 1;

--- So the conclusion is there is no duplicate row's found

--- There is unrelavant data type for order_date and ship_date so we need to convert this to date format

select order_date,ship_date
from sample_superstore;

alter table sample_superstore
add column order_date_dt date,
add column ship_date_dt date;

select * from
sample_superstore;

UPDATE sample_superstore
SET
    order_date_dt = STR_TO_DATE(order_date, '%m/%d/%Y'),
    ship_date_dt  = STR_TO_DATE(ship_date, '%m/%d/%Y');



SELECT order_date
FROM sample_superstore
WHERE order_date LIKE '%/%/%'
LIMIT 50;

select order_date,ship_date,
order_date_dt,ship_date_dt
from sample_superstore;

SELECT
    COUNT(*) AS total_rows,
    COUNT(order_date_dt) AS valid_order_dates,
    COUNT(ship_date_dt) AS valid_ship_dates
FROM sample_superstore;

alter table sample_superstore
drop column order_date,
drop column ship_date;

alter table sample_superstore
rename column order_date_dt to order_date,
rename column ship_date_dt to ship_date;

describe
sample_superstore;

select * from sample_superstore;
