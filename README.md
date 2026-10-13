## Superstore Data Analysis
End-to-end data analysis project using SQL, Tableau, and Power BI on Superstore dataset

📌 #Project Overview

This project is an end-to-end data analytics case study performed on a retail Superstore dataset to analyze sales performance, profitability, customer behavior, and operational efficiency.

The analysis is carried out using SQL for data preparation, Power BI for advanced reporting and KPI analysis.

#Dashboard Overview

<img width="1309" height="735" alt="Screenshot (43)" src="https://github.com/user-attachments/assets/b85e2c06-6768-4c9b-bd8e-0087a29deec2" />

🎯 #Business Problems Addressed

1) Which customers and products contribute most to overall profit?

2) Which products and customers are causing losses, and what factors drive those losses?

3) How do sales and profit vary across regions, categories, and sub-categories?

4) What is the impact of discounts on profitability?

5) How does shipping time vary by product and location, and does it affect profit?
  
6) How is the business performing Year-over-Year?

🛠 #Tools & Technologies Used

--SQL (MySQL) – Data cleaning, aggregation, KPI logic, YoY growth using window functions

--Power BI – Advanced KPIs, DAX measures, drill-down analysis

--Excel / CSV – Source data format

🗂 #Dataset Description

Source: Superstore sales data

Records: ~9,600 rows

Key dimensions:

Customer (Customer ID, Name, Segment)

Product (Category, Sub-category, Product Name)

Geography (Country, Region, State, City)

Time (Order Date, Ship Date)

Measures:

Sales

Quantity

Discount

Profit

🧹 #Data Cleaning & Preparation (SQL)

Identified and handled duplicate order–product records, null values

Standardized all columns by scope

Converted date columns from text to date format

Perfomed data modeling and created different files as fact tables and dimension tables considering star schema

Validated key measures (sales, profit, discount)

📊 #Key KPIs Calculated

-Total Sales

-YOY%

-Profit Margin (%)

-Total Customers

-Average Shipping Time (Days)

-Profit by Category, Sub-Category, Region, Customer, and Product

🔍 #Key Insights

-Technology category generates the highest profit with relatively lower discounts

-Furniture shows high sales volume but lower profitability

-A small group of customers contributes disproportionately to total profit

-High discounts are strongly correlated with loss-making products

-Longer shipping times are observed in certain regions and categories

📈 #Dashboards
Power BI

KPI cards with DAX measures

Executive profitability overview

Category and region-wise performance

Top loss-making products

Time-based trend analysis

🚀 #Future Enhancements

Add time-series forecasting

Automate data refresh

Perform customer segmentation analysis

Integrate Python for deeper analytics

👤 Author

Omkar Zadekar
Data Analyst | SQL | Tableau | Power BI
