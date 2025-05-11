-- CREATE TABLE

CREATE TABLE retail_sales
(
   transactions_id INT PRIMARY KEY,	
   sale_date DATE,	
   sale_time TIME,	
   customer_id INT,	
   gender VARCHAR(15),	
   age INT,	
   category VARCHAR(15),	
   quantiy INT,	
   price_per_unit FLOAT,	
   cogs FLOAT,
   total_sale FLOAT
)

SELECT * FROM retail_sales

SELECT
    COUNT(*)
FROM retail_sales	

--DATA CLEANING

SELECT * FROM retail_sales
WHERE transactions_id is NULL

SELECT * FROM retail_sales
WHERE sale_date is NULL

SELECT * FROM retail_sales
WHERE sale_time is NULL

SELECT * FROM retail_sales
WHERE
     transactions_id is NULL
	 OR
	 sale_date is NULL
	 OR
	 sale_time is NULL
	 OR
	 customer_id is NULL
	 OR 
	 gender is NULL
	 OR
	 age is NULL
	 OR 
	 category is NULL
	 OR
	 quantiy is NULL
	 OR 
	 price_per_unit is NULL
	 OR
	 cogs is NULL
	 OR 
	 total_sale is NULL


DELETE  FROM retail_sales
WHERE
     transactions_id is NULL
	 OR
	 sale_date is NULL
	 OR
	 sale_time is NULL
	 OR
	 customer_id is NULL
	 OR 
	 gender is NULL
	 OR
	 age is NULL
	 OR 
	 category is NULL
	 OR
	 quantiy is NULL
	 OR 
	 price_per_unit is NULL
	 OR
	 cogs is NULL
	 OR 
	 total_sale is NULL

--DATA EXPLORATION

SELECT COUNT(*) as total_sale FROM retail_sales


SELECT COUNT( DISTINCT customer_id) as total_sale FROM retail_sales


SELECT DISTINCT category FROM retail_sales

--Q1

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'

--Q2

SELECT *
FROM retail_sales
WHERE
    category = 'Clothing'
	AND
	TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	AND 
	quantiy >= 4


--Q3

SELECT
     category,
	 SUM(total_sale) as net_sale,
	 COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1


--Q4

SELECT
    ROUND(AVG(age),2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'



--Q5

SELECT * FROM retail_sales
WHERE total_sale > 1000



--Q6

SELECT 
     category,
	 gender,
	 COUNT(*) as total_trans
FROM retail_sales
GROUP
    BY
	category,
	gender
ORDER BY 1	


--Q7


SELECT
      year,
	  month,
	avg_sale  
     
FROM
(
	SELECT
	     EXTRACT(YEAR FROM sale_date) as year,
		 EXTRACT(MONTH FROM sale_date) as month,
		 AVG(total_sale) as avg_sale,
		 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	FROM retail_sales
	GROUP BY 1,2
) as t1
WHERE rank=1
--ORDER BY 1,3 DESC


--Q8


SELECT
      customer_id,
	  SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


--Q9


SELECT
      category,
	  COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category


--Q10


WITH hourly_sales
AS
(
	SELECT *,
	     CASE
		     WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
			 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			 ELSE 'Evening'
		END as shift
	FROM retail_sales	
)
SELECT
     shift,
	 COUNT(*) as total_orders
FROM hourly_sales
GROUP BY shift

	 


	  


	 
	




	
	 
	



	
	 
	 
    
	





