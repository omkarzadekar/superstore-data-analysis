select count(*) from raw_superstore;
select * from raw_superstore;
--1) Lets create staging table from raw table

CREATE TABLE `staging_superstore` (
  `Row ID` int DEFAULT NULL,
  `Order ID` text,
  `Order Date` text,
  `Ship Date` text,
  `Ship Mode` text,
  `Customer ID` text,
  `Customer Name` text,
  `Segment` text,
  `Country` text,
  `City` text,
  `State` text,
  `Postal Code` int DEFAULT NULL,
  `Region` text,
  `Product ID` text,
  `Category` text,
  `Sub-Category` text,
  `Product Name` text,
  `Sales` double DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Discount` double DEFAULT NULL,
  `Profit` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Insert into staging_superstore
select * from raw_superstore;

--2) Now first rename columns 
alter table staging_superstore
rename column `Row ID` to row_id;

alter table staging_superstore
rename column `Order ID` to order_id;

alter table staging_superstore
rename column `Order Date` to order_date;

alter table staging_superstore
rename column `Ship Date` to ship_date;

alter table staging_superstore
rename column `Ship Mode` to ship_mode;

alter table staging_superstore
rename column `Customer ID` to customer_id;

alter table staging_superstore
rename column `Customer Name` to customer_name;

alter table staging_superstore
rename column `Segment` to segment;

alter table staging_superstore
rename column `Country` to country;

alter table staging_superstore
rename column `City` to city;

alter table staging_superstore
rename column `State` to state;

alter table staging_superstore
rename column `Postal Code` to postal_code;

alter table staging_superstore
rename column `Region` to region;

alter table staging_superstore
rename column `Product ID` to product_id;

alter table staging_superstore
rename column `Category` to category;

alter table staging_superstore
rename column `Sub-Category` to sub_category;

alter table staging_superstore
rename column `Product Name` to product_name;

alter table staging_superstore
rename column `Sales` to sales;

alter table staging_superstore
rename column `Quantity` to quantity;

alter table staging_superstore
rename column `Discount` to discount;

alter table staging_superstore
rename column `Profit` to profit;

select * from staging_superstore;

--3) Need to convert columns order_date and ship_date into date format 'mm/dd/YY'

select order_date,ship_date
from staging_superstore;

alter table staging_superstore
add column order_date_clean date,
add column ship_date_clean date;

select * from staging_superstore;

update staging_superstore
set order_date_clean = str_to_date(order_date,'%m/%d/%Y'),
ship_date_clean = str_to_date(ship_date,'%m/%d/%Y');

select order_date,order_date_clean,ship_date,ship_date_clean
from staging_superstore;

alter table staging_superstore
drop column order_date;

alter table staging_superstore
drop column ship_date;

-- rename coulumns order_date_clean and ship_order_date to order_date and ship_date

alter table staging_superstore
rename column order_date_clean to order_date;

alter table staging_superstore
rename column ship_date_clean to ship_date;

select * from staging_superstore;

describe staging_superstore;



