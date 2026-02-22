select * from staging_superstore;
-- Task is to create dimension tables
--1) create dim_customers table with surrogate key and inserting values in it

create table if not exists dim_customers(
customer_key int auto_increment primary key,
customer_id varchar(50) not null,
customer_name varchar(100),
segment varchar(50)
);

select * from dim_customers;

insert into dim_customers(customer_id,customer_name,segment)
select distinct customer_id,customer_name,segment 
from staging_superstore;

select count(distinct customer_id) from staging_superstore;

--2) Tast is create dim_products 
drop table dim_products;

create table dim_products(
product_key int auto_increment primary key,
product_id varchar(50) not null,
product_name varchar(255),
category varchar(100),
sub_category varchar(100)
);

select * from dim_products;

select product_name, length(product_name) as len
from staging_superstore
order by len desc;

insert into dim_products(product_id,product_name,category,sub_category)
select product_id,
max(product_name) as product_name,
max(category) as category,
max(sub_category) as sub_category
from staging_superstore
group by product_id;

--row validation

select count(*)
from dim_products;

select count(distinct product_id)
from staging_superstore;

select product_name, length(product_name) as len
from staging_superstore
group by product_name
order by len desc;

--Task is to create table dim_geography
drop table if exists dim_geography;

create table dim_geography(
geography_key int auto_increment primary Key,
country varchar(50),
region varchar(50),
state varchar(50),
city varchar(50),
postal_code varchar(20)
);

insert into dim_geography(country,region,state,city,postal_code)
select max(country),
max(region),
max(state),
max(city),
postal_code
from staging_superstore
group by postal_code;

select * from dim_geography;
describe staging_superstore;

--validation of dim_geography rows and count of distinct postal_code rows
select count(distinct postal_code)
from staging_superstore;

--Task is to create dim_date table
create table dim_date(
date_key int auto_increment primary key,
full_date date not null,
year int,
quarter int,
month int,
month_name varchar(20),
week int,
day int,
day_name varchar(20),
is_weekend tinyint
);

insert into dim_date(full_date,year,quarter,month,month_name,week,day,day_name,is_weekend)
select d.full_date,
year(d.full_date) as year,
quarter(d.full_date) as quarter,
month(d.full_date) as month,
monthname(d.full_date) as month_name,
week(d.full_date) as week,
day(d.full_date) as day,
dayname(d.full_date)as day_name,
case
	when dayofweek(d.full_date) in (1,7) then 1
    else 0
end as is_weekend
from(
select distinct(order_date) as full_date from staging_superstore
union
select distinct(ship_date) as full_date from staging_superstore
) d;

select * from dim_date;
--validation of row_counts 
SELECT COUNT(*) FROM dim_date;

SELECT COUNT(DISTINCT order_date) + COUNT(DISTINCT ship_date)
FROM staging_superstore;

SELECT COUNT(DISTINCT full_date)
FROM (
    SELECT order_date AS full_date FROM staging_superstore
    UNION
    SELECT ship_date AS full_date FROM staging_superstore
) d;

--Task is to create fact_sales table

create table fact_sales(
order_id varchar(50),
customer_key int,
product_key int,
geography_key int,
order_date_key int,
ship_date_key int,
sales double,
quantity int,
discount double,
profit double
);

insert into fact_sales(order_id,customer_key,product_key,geography_key,order_date_key,ship_date_key,sales,quantity,discount,profit)
select s.order_id,
c.customer_key,
p.product_key,
g.geography_key,
od.date_key,
sd.date_key,
s.sales,
s.quantity,
s.discount,
s.profit
from staging_superstore s
join dim_customers c
on s.customer_id = c.customer_id
join dim_products p
on s.product_id = p.product_id
join dim_geography g
on s.postal_code = g.postal_code
join dim_date od
on s.order_date = od.full_date
join dim_date sd
on s.ship_date = sd.full_date;



SELECT COUNT(*) FROM staging_superstore;
SELECT * FROM fact_sales;

SELECT COUNT(*) AS bad_rows
FROM fact_sales
WHERE customer_key IS NULL
   OR product_key IS NULL
   OR geography_key IS NULL
   OR order_date_key IS NULL
   OR ship_date_key IS NULL;
   

select f.order_id,
d.year,
p.category,
f.sales,
f.profit
from fact_sales f
join dim_date d
on f.order_date_key = d.date_key
join dim_products p
on f.product_key = p.product_key
order by sales desc;


