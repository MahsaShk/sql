select * from customer;
select * from product;
select * from sales;

/* Exercise:*/
/*Get the list of all cities where the region is South or east without any
duplicates using IN statement*/
select distinct city, region from customer where region in ('North','East');

/* Get the list of customers whose last name contains only 4 characters
using LIKE:*/
select * from customer where customer_name like '% ____';

/* ORDER BY*/
select * from customer order by  country ASC, city DESC;
select * from customer order by 2; -- means column index 2 that is customer_name

/*Retrieve all orders where ‘discount’ value is greater than zero, ordered
in descending order basis ‘discount’ value. 
Limit the number of results in above query to top 10*/
select * from sales where discount>0 order by discount DESC  limit 10;

select customer_id as "serial Number" , customer_name as name, age as customer_age from customer
/*serial Number is in "" because there is a space in the column name*/

/*Aggregate function--------------------*/
select count(*) from sales; /* output: 9994  ->meaning 9994 rows*/

/* for customer_id = 'CG-12520' count number of products ordered.
Also count total number of orders*/

select count(order_line) as "number of products ordered", count(distinct order_id) as "number of orders" 
from sales where customer_id = 'CG-12520'; 


/* sum of all sales*/
select sum(sales) as "Sum of all sales" from sales

/*Find count of the number of customers in east region with age
between 20 and 30*/
select count(customer_id) as "Number of Cust-E-20-30" from customer where region = 'East' and age between 20 and 30;
/*Find the average age of East region customers*/
select avg(age) as "Average age of East" from customer where region = 'East' ;

/*Find the Minimum and Maximum aged customer from Philadelphia*/
select min(age) as "min age of Phil", max(age) as "max age of Phil" from customer where city = 'Philadelphia' ;

/* Group BY-----------------------*/
select region , state, count(customer_id) as customer_count from customer group by region, state;
/* quantity of each product?*/
select product_id, sum(quantity) as quantity_sold from sales group by product_id order by quantity_sold DESC;

/* run all aggregate funcs and group by:*/
SELECT customer_id, MIN(sales) AS min_sales,
MAX(sales) AS max_sales,AVG(sales) AS Average_sales,
SUM(sales) AS Total_sales
FROM sales GROUP BY customer_id ORDER BY total_sales DESC
LIMIT 5;

/* WHERE GROUPBY HAVING */
SELECT region, COUNT(customer_id) AS customer_count
FROM customer
WHERE age>18
GROUP BY region
HAVING COUNT(customer_id) > 200 ;

/*Exercise*/
select product_id,sum(sales) as Total_sales_USD, sum(quantity) as Total_sales_quantity, 
count(order_id) as num_of_orders, max(sales) as max_sales, 
min(sales) as min_sales, avg(sales) as avg_sales from sales 
group by product_id having sum(quantity)>10 
order by Total_sales_quantity DESC;

/*CASE*/
select * , case 
when age<30 then 'young'
when age>60 then 'senior'
else 'middle age'
end
as customer_age_group
from customer


