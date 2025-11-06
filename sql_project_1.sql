--- SQL Retail analysis 

--- Create table 

create table retail_sales (
       transactions_id	INT PRIMARY KEY, 
	   sale_date DATE, 
	   sale_time  TIME,
	   customer_id  INT,
	   gender  VARCHAR(15),
	   age INT,
	   category VARCHAR(20),
	   quantiy  INT, 
	   price_per_unit FLOAT,
	   cogs  FLOAT,
	   total_sale  FLOAT

)

SELECT *
FROM retail_sales 

--- Count 

SELECT count(*)
FROM retail_sales 


---

SELECT *
FROM retail_sales
where transactions_id is NULL 
      or 
	  sale_date is NULL
	  or 
	  sale_time is NULL
	  or 
	  customer_id is NULL
	  or 
	  gender is NULL
	  or 
	  age is NULL
	  OR 
	  CATEGORY IS NULL
	  or 
	  quantiy is null 
	  or 
	  price_per_unit is null
	  or 
	  cogs is NULL
	  or 
	  total_sale is NULL

--- 
Delete from retail_sales 
where transactions_id is NULL
      or 
	  sale_date is NULL
	  or 
	  sale_time is NULL
	  or 
	  customer_id is NULL
	  or 
	  gender is NULL
	  or 
	  age is NULL
	  OR 
	  CATEGORY IS NULL
	  or 
	  quantiy is null 
	  or 
	  price_per_unit is null
	  or 
	  cogs is NULL
	  or 
	  total_sale is NULL


--- How many customers we have?

select count(distinct customer_id)
from retail_sales 

--- How many sales we have?

select count(customer_id)
from retail_sales 

--- Data Analysis & busniess key problems and answers 

--- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

 select *
 from retail_sales 
 where sale_date = '2022-11-05' 

--- Q.2 Write a SQL query to retrieve all transcations where the catrgory is 'Clothing' and the quantity said is more than 10 in the month of nov-2022

select *
from retail_sales 
where CATEGORY = 'Clothing' 
      and
	  to_char(sale_date,'YYYY-MM') = '2022-11'
	  and quantiy >= 4
order by sale_date ASC

---  Q.3 Write a SQL query to calculate the total sales for each category 

select category, 
       sum(total_sale) as net_sales
from retail_sales
group by 1
order by 2 DESC

---  Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

select round(avg(age),2) as avg_age
from retail_sales 
where category = 'Beauty'

---  Q.5 Write a SQL query to find all transcations where the total_sales is greater than 1000.

select customer_id, transactions_id, category, total_sale
from retail_sales 
where total_sale >1000
order by 4 DESC

---  Q.6 Write a SQL query to find the total number of transcations made by each gender in each category 

Select category,gender, count(transactions_id)
from retail_sales
group by 1,2 
order by 1 

---  Q.7 Write a SQL query to find the average sale for each month. Find out best selling month in each year 

select to_char(sale_date,'YYYY') as year,
       to_char(sale_date,'Mon') as month,
	   avg(total_sale) as avg_sale
from retail_sales
group by 1 ,2
order by 3 DESC

---or 

select *
from (
select extract(Year from sale_date) as year,
       extract(Month from sale_date) as month,
	   avg(total_sale) as avg_sale,
	   rank() over(partition by extract(Year from sale_date) order by avg(total_sale) desc ) as rank
from retail_sales
group by 1 ,2
)

where rank =1 

---  Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id, sum(total_sale) as net_sale 
from retail_sales
group by 1 
order by 2 desc
limit 5 

---  Q.9 Write a SQL query to find the number of unique customers who purchased items from each category

select category, 
       count(distinct customer_id) as unique_customer
from  retail_sales
group by 1

---  Q.10 Write a SQL query to create each shift and number of orders (Example morning <=12, afternoon netween 12 & 17, evening > 17)

with hourly_sale 
as(
select sale_time, 
       case
	       when extract( hour from sale_time) < 12  then ('Morning')
		   when extract( hour from sale_time) between 12 and 17 then ('Afternoon')
		   else ('Evening')
	   end as shift 
from retail_sales 
)

select  shift, 
        count(*) as total_orders
from hourly_sale 
group by shift
order by 2 DESC

--- END OF PROJECT 
