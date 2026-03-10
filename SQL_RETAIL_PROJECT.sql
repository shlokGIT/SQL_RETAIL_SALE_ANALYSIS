-- COMMAND TO CREATE DATABASE
CREATE DATABASE sql_retail_project;

-- to use this database
use sql_retail_project;

-- CREATE TABLE
CREATE TABLE retailSales (
    transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(20),
	age	INT,
    category VARCHAR(20),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT 
);
-- TO RETRIEVE ALL COL IN A TABLE
SELECT * FROM retailSales;

-- TO RETRIEVE 10 COL FROM TABLE
SELECT * FROM retailSales
LIMIT 10;

-- TO COUNT ALL COL FROM TABLE
SELECT Count(*) FROM retailSales;

-- TO finds all rows in the retailSales table that contain empty ('') or NULL values
SELECT * FROM retailSales 
WHERE
     transactions_id = ''
     or
     sale_date IS NULL
     or
	 sale_time = ''
     or
     customer_id = ''
     or
     gender = ''
     or
     age = ''
     or
     category = ''
     or
     quantiy = ''
     or
     price_per_unit = ''
     or
     cogs = ''
     or
     total_sale = '';
   
-- DATA CLEANING   
-- TO DELETE NUL AND BLANK VALUES FROM TABLE  
DELETE FROM retailSales 
WHERE
     transactions_id = ''
     or
     sale_date IS NULL
     or
	 sale_time = ''
     or
     customer_id = ''
     or
     gender = ''
     or
     age = ''
     or
     category = ''
     or
     quantiy = ''
     or
     price_per_unit = ''
     or
     cogs = ''
     or
     total_sale = '';
     
     -- DATA EXPLORATION
-- the total number of rows (records) in the retailSales table and displays the result with the column name total_sale.     
SELECT Count(*) AS total_sale FROM retailSales;   

-- counts the total number of non-NULL customer_id values in the retailSales table and displays the result as total_customer.
SELECT Count(customer_id) AS total_Customer FROM retailSales;   

-- counts the total number of unique (distinct) customer_id values in the retailSales table and displays it as Unique_Customer.
SELECT Count(DISTINCT customer_id) AS Unique_Customer FROM retailSales;  

-- returns all unique values from the category column in the retailSales table, removing duplicate categories.
SELECT DISTINCT category FROM retailSales; 

-- DATA ANALYSIS && BUSSINESS PROBLEMS
-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retailSales
WHERE sale_date = '2022-11-05' ;


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM retailSales
WHERE category = 'Clothing' 
      AND date_format(sale_date , '%Y-%M') = '2022-11'
      AND quantiy >= 2; 
      

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.  
SELECT DISTINCT category,SUM(total_sale) AS TOTAL_SALE FROM retailSales
GROUP BY category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT category ,
       ROUND(avg(age),0) 
FROM retailSales
WHERE category = 'Beauty'   ;

  
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT transactions_id , total_sale as TOTAL_SALE FROM retailSales
WHERE TOTAL_SALE >= 1000   ;   


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category,
       gender,
       COUNT(transactions_id) AS TOTAL_TRANSACTION
FROM retailSales
GROUP BY category,gender;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT YEAR,
       MONTH,
       AVG_SALE
FROM (       
SELECT YEAR(sale_date) AS YEAR,
       MONTH(sale_date) AS MONTH,
       ROUND(AVG(total_sale),2) AS AVG_SALE,
       RANK() OVER( 
                   PARTITION BY YEAR(sale_date) 
                   ORDER BY AVG(total_sale) DESC
				  ) as rnk
FROM retailSales
GROUP BY YEAR(sale_date) , MONTH(sale_date)
) AS T1
WHERE rnk = 1;


--  Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT SUM(total_sale) AS TOTAL_SALE , 
	   customer_id AS TOP_CUSTOMER
FROM retailSales
GROUP BY TOP_CUSTOMER
ORDER BY total_sale DESC
LIMIT 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT COUNT(DISTINCT customer_id) AS UNIQUE_CUSTOMER , 
       category 
FROM retailSales
GROUP BY category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH HOURLY_SALE AS (
SELECT *,
CASE
    WHEN HOUR(sale_time) <= 12 THEN 'MORNING'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17  THEN 'AFTERNOON'
    WHEN HOUR(sale_time) >=17 THEN 'EVENING'
    ELSE 'NIGHT'
END AS SHIFT
FROM retailSales
)
SELECT SHIFT,
       COUNT(*) AS TOTAL_ORDERS
       FROM HOURLY_SALE
       GROUP BY SHIFT
       
       
  
    
    









       





     
     




