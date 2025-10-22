# Retail Sales Analysis SQL Project

## Project Overview

*Project Title*: Retail Sales Analysis  
*Level*: Beginner  
*Database*: sql_project_p2

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

### Objectives

1. *Set up a retail sales database*: Create and populate a retail sales database with the provided sales data.
2. *Data Cleaning*: Identify and remove any records with missing or null values.
3. *Exploratory Data Analysis (EDA)*: Perform basic exploratory data analysis to understand the dataset.
4. *Business Analysis*: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- *Database Creation*: The project starts by creating a database named sql_project_p2.
- *Table Creation*: A table named retail_sales is created to store the sales data. The table structure includes columns for invoice_no, customer_id, invoice_date , price, gender, age, category, quantity,  payment_method and shopping_mall.

'''sql
CREATE DATABASE sql_project_p2;

DROP TABLE IF EXISTS retail_sales; 
CREATE TABLE retail_sales
		(
	 		invoice_no	VARCHAR(10) PRIMARY KEY,
			 customer_id VARCHAR(10),	
			 gender	VARCHAR(10),
			 age INT,	
			 category VARCHAR(25),	
			 quantity INT,	
			 price FLOAT,
			 payment_method	VARCHAR(10),
			 invoice_date DATE,	
			 shopping_mall VARCHAR(25)
		);
'''

### 2. Data Exploration & Cleaning

- *Record Count*: Determine the total number of records in the dataset.
- *Customer Count*: Find out how many unique customers are in the dataset.
- *Category Count*: Identify all unique product categories in the dataset.
- *Null Value Check*: Check for any null values in the dataset and delete records with missing data.

'''sql
SELECT * FROM retail_sales
WHERE invoice_no IS NULL
	  OR
	  customer_id IS NULL
	  OR
	  gender IS NULL
	  OR
	  age IS NULL
	  OR
	  category IS NULL
	  OR
	  quantity IS NULL
	  OR
	  price IS NULL
	  OR
	  payment_method IS NULL
	  OR
	  invoice_date IS NULL
	  OR
	  shopping_mall IS NULL;

DELETE FROM retail_sales
WHERE invoice_no IS NULL
	  OR
	  customer_id IS NULL
	  OR
	  gender IS NULL
	  OR
	  age IS NULL
	  OR
	  category IS NULL
	  OR
	  quantity IS NULL
	  OR
	  price IS NULL
	  OR
	  payment_method IS NULL
	  OR
	  invoice_date IS NULL
	  OR
	  shopping_mall IS NULL;

SELECT COUNT(*) as total_sale FROM retail_sales
SELECT COUNT(customer_id) as total_sale FROM retail_sales
SELECT DISTINCT category  FROM retail_sales
'''

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. *Write a SQL query to retrieve all columns for sales made on '2022-11-05'*:
''sql
SELECT *
FROM retail_sales
WHERE invoice_date = '2022-11-05';
'''

2. *Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022*:
'''sql
SELECT *
FROM retail_sales
WHERE category='Clothing'
	  AND
	  quantity >= 3
	  AND
	  TO_CHAR(invoice_date,'YYYY-MM') = '2022-11';
'''

3. *Write a SQL query to calculate the total sales (total_sale) for each category.*:
'''sql
SELECT 
	category,
	COUNT('category') as net_sales
FROM retail_sales
GROUP BY 1
'''

4. *Write a SQL query to find the average age of customers who purchased items from the 'Clothing' category.*:
'''sql
SELECT 
	AVG(age) AS avg_age
FROM retail_sales
WHERE category='Clothing'
'''

5. *Write a SQL query to find all transactions where the price is greater than 100.*:
'''sql
SELECT *
FROM retail_sales
WHERE price > 100 ;
'''

6. *Write a SQL query to find the total number of transactions (customer_id) made by each gender in each category.*:
'''sql
SELECT  
	category ,
	gender ,
	COUNT(*) as total_trans
FROM retail_sales
GROUP 
	BY
	category,
	gender
ORDER BY 1
'''

7. *Write a SQL query to calculate the average price for each month. Find out best selling month in each year.*:
'''sql
SELECT 
	year,
	month,
	avg_price
FROM 
(
SELECT 
	EXTRACT(YEAR FROM invoice_date) as year,
	EXTRACT(MONTH FROM invoice_date) as month,
	AVG(price) as avg_price ,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM invoice_date) ORDER BY AVG(price) DESC) as rank
FROM retail_sales
GROUP BY 1,2
) as t1
WHERE rank = 1
'''

8. *Write a SQL query to find the top 5 category based on the highest total price.*:
'''sql
SELECT 
	category,
	SUM(price) as total_price
FROM retail_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
'''

9. *Write a SQL query to find the number of unique customers who purchased items from each category.*:
'''sql
SELECT 
    category,
	COUNT(DISTINCT customer_id) as uni_customer
FROM retail_sales 
GROUP BY category
'''
10. *Write a sql query to create each payment_method and number of orders .*:
'''sql
SELECT 
	payment_method,
	COUNT(customer_id) as num_of_orders
FROM retail_sales 
GROUP BY payment_method
'''

11. *Write a SQL query to create each years and number of orders *:
'''sql
WITH yearly_sale
AS
(
SELECT * ,
	CASE
		WHEN EXTRACT(YEAR FROM invoice_date)= 2021 THEN '2021'
		WHEN EXTRACT(YEAR FROM invoice_date)= 2022 THEN '2022'
		ELSE '2023'
	END as year
FROM retail_sales
)
SELECT
	year ,
	COUNT(*) as total_orders
FROM yearly_sale
GROUP BY year
ORDER BY year
'''

## Findings

- *Customer Demographics*: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- *High-Value Transactions*: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- *Sales Trends*: Monthly analysis shows variations in sales, helping identify peak seasons.
- *Customer Insights*: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- *Sales Summary*: A detailed report summarizing total orders, customer demographics, and category performance.
- *Trend Analysis*: Insights into sales trends across different years.
- *Customer Insights*: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
