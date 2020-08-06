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
/*subquery-----------------------------*/
/* subquery in WHERE clause:
return all the sales where the customer's age >60*/
select * from sales where customer_id in (select customer_id from customer where age >60);

/* subquery in FROM clause:
find out quantity of each product sold. Result must be: product id, name, category, quantity*/
select a.product_id,
		a.product_name,
		a.category,
		b.quantity
from product as a
left join
(select product_id, sum(quantity) as quantity from sales group by product_id) as b
on a.product_id = b.product_id
order by b.quantity DESC;

/* subquery in SELECT clause: The same as LEFT JOINT! 
Note that JOIN has lower cost rather than supqueries.
Find order_line and customer_id and customer_name:*/

select customer_id, order_line, 
(select customer_name from customer where customer.customer_id= sales.customer_id )
from sales
order by customer_id;


/*Exercise:
Get data with all columns of sales table, and customer name, customer
age, product name and category are in the same result set. (use JOIN in
subquery)
*/
/*solution1 */
select cust.customer_name, cust.age, s.* , prod.product_name,prod.category
from sales as s 
left join (select customer_id, customer_name, age from customer) as cust
on s.customer_id = cust.customer_id
left join (select product_id, product_name, category from product) as prod
on s.product_id = prod.product_id;

/*another solution2:*/
select c.customer_name, c.age, sp.* from
customer as c
right join (select s.*, p.product_name, p.category
from sales as s
left join product as p
on s.product_id = p.product_id) as sp
on c.customer_id = sp.customer_id;



/*JOIN ---------------------------------*/
/* First create two sub tables: */
/*Creating sales table of year 2015*/

Create table sales_2015 as select * from sales where ship_date between '2015-01-01' and '2015-12-31';
select count(*) from sales_2015; --2131
select count(distinct customer_id) from sales_2015;--578

/* Customers with age between 20 and 60 */
create table customer_20_60 as select * from customer where age between 20 and 60;
select count (*) from customer_20_60;--597


SELECT 
a.order_line,
a.product_id,
a.customer_id,
a.sales,
b.customer_name,
b.age
from sales_2015 as a
inner join customer_20_60 as b
on a.customer_id = b.customer_id
order by customer_id;

/* CROSS Example:*/

create table month_values (MM integer);
create table year_values (YYYY integer);

insert into month_values values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12);
insert into year_values values (2011),(2012),(2013),(2014),(2015),(2016),(2017),(2018),(2019),(2020);
	
select y.*, m.* 
from year_values as y, month_values as m;


/*EXCEPT:
Return all rows in the first SELECT clause that 
are not returned by the second SELECT clause.*/

SELECT customer_id
FROM sales_2015
EXCEPT
SELECT customer_id
FROM customer_20_60
ORDER BY customer_id;

/*UNION:
Combine the result sets of 2 or more SELECT statements. 
It removes duplicate rows between the various SELECT statements.
*/
SELECT customer_id
FROM sales_2015
UNION
SELECT customer_id
FROM customer_20_60
ORDER BY customer_id;

/*Exercise:
Find the total sales done in every state for customer_20_60 and
sales_2015 table*/

select res.state , sum (res.sales) from (select s.*, c.state from sales_2015 as s
inner join (select customer_id ,state from customer_20_60) as c
on s.customer_id =c.customer_id) as res group by res.state;

/*shorter solution:*/
select b.state, sum(sales) as total_sales
from sales_2015 as a left join customer_20_60 as b
on a.customer_id = b.customer_id
group by b.state;

/*Get data containing Product_id, product name, category, total sales
value of that product and total quantity sold. (Use sales and product
table)
*/

select p.Product_id, p.product_name, p.category, res.total_sales, res.total_quantity from product as p
right join (select s.product_id, sum(s.sales) as total_sales, sum(s.quantity) as total_quantity from sales as s group by s.product_id) as res
on p.Product_id = res.product_id;
/*another solution*/
select a.*, sum(b.sales) as total_sales, sum(quantity) as total_quantity
from product as a left join sales as b
on a.product_id = b.product_id
group by a.product_id;


