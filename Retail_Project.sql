--Retail Project

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
WHERE shopping_mall IS NULL
	  OR
	  invoice_no IS NULL
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
WHERE shopping_mall IS NULL
	  OR
	  invoice_no IS NULL
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

--Write a sql query to all colums for sales made on '2022-11-05'
SELECT *
FROM retail_sales
WHERE invoice_date = '2022-11-05';

--Write a sql query to all transactions where the category where the category is 'clothing' and quantity sold is more than 3 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category='Clothing'
	  AND
	  quantity >= 3
	  AND
	  TO_CHAR(invoice_date,'YYYY-MM') = '2022-11';

--Write a sql query to calculate the total sales for each catogory
SELECT 
	category,
	COUNT('category') as net_sales
FROM retail_sales
GROUP BY 1

--Write a sql query to find the avarage sale age of customers who purchased items from the 'Clothing' category
SELECT 
	AVG(age) AS avg_age
FROM retail_sales
WHERE category='Clothing'

--Write a sql query to find all transactions where the price is greater than 100
SELECT *
FROM retail_sales
WHERE price > 100 ;

--Write a sql query to find the total number of transactions (customer_id) made by each gender in each category
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

--Write a sql query to calculate the average price for each month. Find out best selling month in each year
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

--Write a sql query to find the top 5 category based on the highest total price
SELECT 
	category,
	SUM(price) as total_price
FROM retail_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Write a sql query to find the number of unique  customers who purchased items from each category
SELECT 
    category,
	COUNT(DISTINCT customer_id) as uni_customer
FROM retail_sales 
GROUP BY category

--Write a sql query to create each payment_method and number of orders 
SELECT 
	payment_method,
	COUNT(customer_id) as num_of_orders
FROM retail_sales 
GROUP BY payment_method

--Write a sql query to represent year
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

--End of Project