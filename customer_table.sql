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
 
copy customer_table from '/home/mahsa/Documents/code/sql_postgres/sql/Data/copy.csv' delimiter ',' csv header;
 
copy customer_table from '/home/mahsa/Documents/code/sql_postgres/sql/Data/copytext.txt' delimiter ',' ;

select distinct first_name, last_name from customer_table; 

select first_name, last_name, age from customer_table where age>23 AND Not age <30;

select first_name, last_name, age from customer_table where age not between 23 and 30;

update customer_table set age =17, last_name='Pe' where cust_id =2;
select * from customer_table;

update customer_table set email_id = 'gee@xyz.com' where first_name='Gee' or first_name='gee';
select * from customer_table;

/*Delete rows */
delete from customer_table where cust_id=6;
select * from customer_table;

delete from customer_table where cust_id=6;
select * from customer_table;

delete from customer_table;
select * from customer_table;

/*ALTER TABLE tablename [actions];--------------------*/
/* 1- ADD/DROP a column */
alter table customer_table add test varchar(255);
select * from customer_table;

alter table customer_table drop test; /*Note: DROP COLUMN could be used instead of DROP, the result will be the same*/
select * from customer_table;

/* 2- MODIFY TYPE of a column */
alter table customer_table alter column age type varchar(255);
select * from customer_table;

/* 3- RENAME a column */
alter table customer_table rename column email_id to customer_email;
select * from customer_table;

/* 4- add a constraint to a column 
   4-1- SET NOT NULL coinstrant */

alter table customer_table alter column cust_id set not null;
insert into customer_table (first_name,last_name,age,customer_email) values
('aa','bb','25','abc@xyz.com');
/* ERROR:  null value in column "cust_id" */
 
 /*4-2- DROP NOT NULL coinstrant: this will drop the 4-1 constraint */
 alter table customer_table alter column cust_id drop not null;
insert into customer_table (first_name,last_name,age,customer_email) values
('aa','bb','25','abc@xyz.com');
select * from customer_table;

/*4-3- CHECK coinstrant*/
alter table customer_table add constraint cust_id check (cust_id>0);
insert into customer_table values(-1,'cc','dd','67','cd@xyz.com');
/* ERROR: violates check constraint "cust_id"  */

/*4-4- add primary key constraint to a column */
/*before we should make sure the cust_id has no null values */
delete from customer_table where cust_id is null;

alter table customer_table add primary key (cust_id);
select * from customer_table;

/*4-5- add foregin key constraint to a column */
/*ALTER TABLE “child_table" ADD CONSTRAINT “child_column”
FOREIGN KEY (“parent column”) REFERENCES “parent table”;*/


