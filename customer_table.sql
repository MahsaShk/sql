create table Customer_table (
cust_id int,
First_name varchar,
Last_name varchar,
age int,
email_id varchar);

insert into Customer_table
values (1,'bee','cee',32,'bc@xyz.com');

insert into Customer_table(cust_id, first_name, age,email_id)
values (2,'dee',23,'d@xyz.com');

insert into customer_table 
values 
(3,'ee','ef',27,'ef@xyz.com'),
(4,'gee','eh',35,'gh@xyz.com');
 
copy customer_table from '/home/mahsa/Documents/code/sql_postgres/Data/copy.csv' delimiter ',' csv header;
 
copy customer_table from '/home/mahsa/Documents/code/sql_postgres/Data/copytext.txt' delimiter ',' ;

select distinct first_name, last_name from customer_table; 

select first_name, last_name, age from customer_table where age>23 AND Not age <30;

select first_name, last_name, age from customer_table where age not between 23 and 30;

update customer_table set age =17, last_name='Pe' where cust_id =2;

update customer_table set email_id = 'gee@xyz.com' where first_name='Gee' or first_name='gee';

select * from customer_table;



