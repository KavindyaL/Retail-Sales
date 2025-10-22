--Retail Sales Analysis SQL Project

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

SELECT * FROM retail_sales;

SELECT * FROM public.retail_sales
ORDER BY invoice_no ASC LIMIT 100

SELECT * FROM retail_sales
LIMIT 10

SELECT 
	COUNT(*) 
FROM retail_sales

SELECT * FROM retail_sales
WHERE invoice_no IS NULL

SELECT * FROM retail_sales
WHERE customer_id IS NULL

SELECT * FROM retail_sales
WHERE age IS NULL

SELECT * FROM retail_sales
WHERE category IS NULL

SELECT * FROM retail_sales
WHERE quantity IS NULL

SELECT * FROM retail_sales
WHERE price IS NULL

SELECT * FROM retail_sales
WHERE payment_method IS NULL

SELECT * FROM retail_sales
WHERE invoice_date IS NULL

SELECT * FROM retail_sales
WHERE shopping_mall IS NULL

--Data Cleaning
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

--Data Exploration
--How many sales we have
SELECT COUNT(*) as total_sale FROM retail_sales

--How many customer we have
SELECT COUNT(customer_id) as total_sale FROM retail_sales

--What are categories we have
SELECT DISTINCT category  FROM retail_sales

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
SELECT *
FROM retail_sales
WHERE invoice_date = '2022-11-05';

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
SELECT *
FROM retail_sales
WHERE category='Clothing'
	  AND
	  quantity >= 3
	  AND
	  TO_CHAR(invoice_date,'YYYY-MM') = '2022-11';

--3.Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	category,
	COUNT('category') as net_sales
FROM retail_sales
GROUP BY 1

--4.Write a SQL query to find the average age of customers who purchased items from the 'Clothing' category.
	AVG(age) AS avg_age
FROM retail_sales
WHERE category='Clothing'

--5.Write a SQL query to find all transactions where the price is greater than 100.
SELECT *
FROM retail_sales
WHERE price > 100 ;

--6.Write a SQL query to find the total number of transactions (customer_id) made by each gender in each category.
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

--7.Write a SQL query to calculate the average price for each month. Find out best selling month in each year.
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

--8.Write a SQL query to find the top 5 category based on the highest total price.
	category,
	SUM(price) as total_price
FROM retail_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--9.Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,
	COUNT(DISTINCT customer_id) as uni_customer
FROM retail_sales 
GROUP BY category

--10.Write a sql query to create each payment_method and number of orders. 
SELECT 
	payment_method,
	COUNT(customer_id) as num_of_orders
FROM retail_sales 
GROUP BY payment_method

--11.Write a SQL query to create each years and number of orders.
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

--End of the Project