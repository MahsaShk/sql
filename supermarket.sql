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