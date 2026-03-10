# SQL_RETAIL_SALE_ANALYSIS

# PROJECT OVERVIEW

-This project focuses on analyzing retail sales data using SQL to extract meaningful business insights. The dataset contains transaction-level information such as customer details, product categories, quantity purchased, and total sales.

-The goal of this project is to demonstrate data cleaning, data exploration, and business analysis using SQL queries.

-Through this project, several important business questions are answered, helping organizations understand customer behavior, product performance, and sales trends.

# OBJECTIVES

-The main objectives of this project are:

-Perform data cleaning to remove null and invalid records.

-Explore the dataset to understand its structure.

-Use SQL to answer real-world business questions.

-Generate insights about customers, sales, and product categories.


# DATASET DESCRIPTION
![SQL_RETAIL_SALE_DATASET](https://github.com/shlokGIT/SQL_RETAIL_SALE_ANALYSIS/blob/main/Screenshot%20(408).png?raw=true)

# Database & Table Creation
   Create Database
```   
CREATE DATABASE sql_retail_project;
```
   Use Database
```   
USE sql_retail_project;
```
   Create Table
```   
CREATE TABLE retailSales (
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(20),
age INT,
category VARCHAR(20),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);
```

# Data Cleaning

Identify Null or Blank Values
```
SELECT * FROM retailSales
WHERE
transactions_id = ''
OR sale_date IS NULL
OR sale_time = ''
OR customer_id = ''
OR gender = ''
OR age = ''
OR category = ''
OR quantiy = ''
OR price_per_unit = ''
OR cogs = ''
OR total_sale = '';
```

Remove Invalid Records
```
DELETE FROM retailSales
WHERE
transactions_id = ''
OR sale_date IS NULL
OR sale_time = ''
OR customer_id = ''
OR gender = ''
OR age = ''
OR category = ''
OR quantiy = ''
OR price_per_unit = ''
OR cogs = ''
OR total_sale = '';
```
# Data Exploration

Total Records
```
SELECT COUNT(*) AS total_sale FROM retailSales;
```
Total Customers
```
SELECT COUNT(customer_id) AS total_customer FROM retailSales;
```
Unique Customers
```
SELECT COUNT(DISTINCT customer_id) AS unique_customer FROM retailSales;
```
Product Categories
```
SELECT DISTINCT category FROM retailSales;
```
# Business Problems & SQL Analysis

Q1. Retrieve all sales made on a specific date
```
SELECT * FROM retailSales
WHERE sale_date = '2022-11-05';
```
Q2. Clothing transactions with quantity greater than 4 in Nov 2022
```
SELECT *
FROM retailSales
WHERE category = 'Clothing'
AND DATE_FORMAT(sale_date,'%Y-%m')='2022-11'
AND quantiy >= 2;
```
Q3. Total sales by category
```
SELECT category,
SUM(total_sale) AS total_sales
FROM retailSales
GROUP BY category;
```
Q4 Average age of customers buying Beauty products
```
SELECT
ROUND(AVG(age),0)
FROM retailSales
WHERE category = 'Beauty';
```
Q5. Transactions where total sale exceeds 1000
```
SELECT transactions_id,total_sale
FROM retailSales
WHERE total_sale >= 1000;
```
Q6. Total transactions by gender and category
```
SELECT
category,
gender,
COUNT(transactions_id) AS total_transactions
FROM retailSales
GROUP BY category,gender;
```
Q7. Best selling month in each year
```
SELECT YEAR,
MONTH,
AVG_SALE
FROM(
SELECT
YEAR(sale_date) AS YEAR,
MONTH(sale_date) AS MONTH,
ROUND(AVG(total_sale),2) AS AVG_SALE,
RANK() OVER(
PARTITION BY YEAR(sale_date)
ORDER BY AVG(total_sale) DESC
) AS rnk
FROM retailSales
GROUP BY YEAR(sale_date),MONTH(sale_date)
) AS T1
WHERE rnk = 1;
```
Q8. Top 5 customers by highest sales
```
SELECT
SUM(total_sale) AS total_sale,
customer_id
FROM retailSales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;
```
Q9. Unique customers per category
```
SELECT
COUNT(DISTINCT customer_id) AS unique_customer,
category
FROM retailSales
GROUP BY category;
```
Q10. Orders by sales shift

Morning → Before 12 PM

Afternoon → 12 PM – 5 PM

Evening → After 5 PM
```
WITH HOURLY_SALE AS (
SELECT *,
CASE
WHEN HOUR(sale_time) <= 12 THEN 'MORNING'
WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
WHEN HOUR(sale_time) >= 17 THEN 'EVENING'
ELSE 'NIGHT'
END AS SHIFT
FROM retailSales
)

SELECT
SHIFT,
COUNT(*) AS total_orders
FROM HOURLY_SALE
GROUP BY SHIFT;
```

# KEY INSIGHTS

Some important insights derived from the analysis:

-Certain product categories generate higher revenue than others.

-A small group of customers contribute significantly to total sales.

-Seasonal monthly trends affect sales performance.

-Different sales shifts (morning/afternoon/evening) show varying transaction volumes.

-Customer demographics such as age and gender influence purchasing behavior.

# TOOLS & TECHNOLOGY USED

-SQL (MySQL).

-Data Cleaning.

-Data Exploration.

-Window Functions.

-Aggregation Functions.

-Business Analysis using SQL.

# SQL_SCHEMA_STRUCTURE
![SQL FOLDER STRUCTURE](https://github.com/shlokGIT/SQL_RETAIL_SALE_ANALYSIS/blob/main/Screenshot%20(411).png?raw=true)

# PROJECT_STRUCTURE
```
SQL_RETAIL_SALE_ANALYSIS
   |--README.md
   |--SQL-Retail Sales Analysis_utf.csv
   |--SQL_RETAIL_PROJECT.SQL
   |--Screenshot(408).png
   |--Screenshot(411).png
```
   
# Author

Shlok Singh

Aspiring Data Analyst | SQL | Power BI | Ms Excel | Data Visualization















