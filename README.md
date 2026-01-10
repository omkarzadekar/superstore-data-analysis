# superstore-data-analysis
End-to-end data analysis project using SQL, Tableau, and Power BI on Superstore dataset

📌 Project Overview

This project is an end-to-end data analytics case study performed on a retail Superstore dataset to analyze sales performance, profitability, customer behavior, and operational efficiency.

The objective is to help business stakeholders answer:

Where are we making money, where are we losing money, and why?

The analysis is carried out using SQL for data preparation, Tableau for exploratory visualization, and Power BI for advanced reporting and KPI analysis.

🎯 Business Problems Addressed

Which customers and products contribute most to overall profit?

Which products and customers are causing losses, and what factors drive those losses?

How do sales and profit vary across regions, categories, and sub-categories?

What is the impact of discounts on profitability?

How does shipping time vary by product and location, and does it affect profit?

🛠 Tools & Technologies Used

SQL (MySQL) – Data cleaning, aggregation, KPI calculations

Tableau – Interactive dashboards and exploratory analysis

Power BI – Advanced KPIs, DAX measures, drill-down analysis

Excel / CSV – Source data format

🗂 Dataset Description

Source: Superstore sales data

Records: ~9,600 rows

Key dimensions:

Customer (Customer ID, Name, Segment)

Product (Category, Sub-category, Product Name)

Geography (Country, Region, State, City)

Time (Order Date, Ship Date)

Measures:

Sales, Quantity, Discount, Profit

🧹 Data Cleaning & Preparation (SQL)

Identified and handled duplicate order–product records

Converted date columns from text to date format

Created an aggregated fact table at order–product level to avoid double counting

Validated key measures (sales, profit, discount)

📌 Why aggregation?
To ensure accurate KPI calculations and avoid misleading results caused by duplicate transactional rows.

📊 Key KPIs Calculated

Total Sales

Total Profit

Profit Margin (%)

Average Discount

Average Shipping Time (Days)

Profit by Category, Sub-Category, Region, Customer, and Product

🔍 Key Insights

Technology category generates the highest profit with relatively lower discounts

Furniture shows high sales volume but lower profitability

A small group of customers contributes disproportionately to total profit

High discounts are strongly correlated with loss-making products

Longer shipping times are observed in certain regions and categories

📈 Dashboards
Tableau

Executive profitability overview

Category and region-wise performance

Top products and loss-making segments

Power BI

KPI cards with DAX measures

Drill-through analysis by customer and product

Time-based trend analysis

📂 Project Structure
superstore-data-analysis/
│
├── data/
│   └── sample_superstore.csv
│
├── sql/
│   ├── data_cleaning.sql
│   ├── aggregation.sql
│   └── business_queries.sql
│
├── tableau/
│   └── superstore_dashboard.twbx
│
├── powerbi/
│   └── superstore_dashboard.pbix
│
└── README.md

🚀 Future Enhancements

Add time-series forecasting

Automate data refresh

Perform customer segmentation analysis

Integrate Python for deeper analytics

👤 Author

Omkar Zadekar
Aspiring Data Analyst | SQL | Tableau | Power BI
