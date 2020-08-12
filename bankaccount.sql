DROP table  bankaccount;
create table bankaccount(Date date, Weekday varchar, Amount money, ACCtType varchar, OpenedBy varchar, Branch varchar, Customer varchar);
COPY bankaccount (Date , Weekday , Amount , ACCtType , OpenedBy , Branch , Customer )
FROM '/home/mahsa/Documents/code/sql_postgres/sql/Data/bank+accounts.csv' DELIMITER ',' CSV HEADER 

select * from bankaccount
/* What is the daily total new deposit amount for each branch?  c1=date c2=branch1 c3=branch2 ...*/

select tc.date,tc.totalamnt as central, tw.totalamnt as westside, tn.totalamnt as NorthCounty from (select date, sum(amount) as totalamnt from bankaccount 
group by date, branch having branch ='Central') as tc

left join (select t2.date,t2.totalamnt from (select date, sum(amount) as totalamnt from bankaccount 
group by date,branch having branch ='Westside')as t2) as tw
on tc.date = tw.date

left join 
(select t3.date,t3.totalamnt from (select date, sum(amount) as totalamnt from bankaccount 
group by date,branch having branch ='North County')as t3) as tn
on tc.date = tn.date

order by tc.date




/*■■ Which day of the week accounts for the most deposits?*/
select t.weekday, max(t.totalamount) as maxamount from 
(select date, weekday, sum(amount) as totalamount from bankaccount  group by weekday, date) as t 
group by t.weekday order by maxamount DESC limit 1
-- ANSWER: FRIDAY

/*■■ How many accounts were opened at each branch, broken down by account type?*/

select * from bankaccount

Create table acntBr as select tc.accttype, tc.cnt as central, tw.cnt as westside, tn.cnt as NorthCounty from (select accttype, count(accttype) as cnt from bankaccount 
group by accttype, branch having branch ='Central') as tc

left join (select t2.accttype,t2.cnt from (select accttype, count(accttype) as cnt from bankaccount 
group by accttype, branch having branch ='Westside')as t2) as tw
on tc.accttype = tw.accttype

left join 
(select t3.accttype,t3.cnt from (select accttype, count(accttype) as cnt from bankaccount 
group by branch, accttype having branch ='North County' )as t3) as tn
on tc.accttype = tn.accttype;



select * from acntBr;
alter table acntBr add TotalResult int;
update acntBr set TotalResult=(select count(accttype)from bankaccount where accttype ='Savings') where accttype ='Savings';
update acntBr set TotalResult=(select count(accttype)from bankaccount where accttype ='CD') where accttype ='CD';
update acntBr set TotalResult=(select count(accttype)from bankaccount where accttype ='IRA') where accttype ='IRA';
update acntBr set TotalResult=(select count(accttype)from bankaccount where accttype ='Checking') where accttype ='Checking';

insert into acntBr(accttype,central,westside,northcounty,totalresult) 
values ('totalresults',
(select sum(central)from acntBr),	
(select sum(westside)from acntBr),
(select sum(northcounty)from acntBr),
(select sum(totalresult)from acntBr))


/*■■ How much money was used to open accounts?*/
select sum(amount) from bankaccount  
--- Answer : $6,611,959.00
/*■■ What types of accounts do tellers open most often?*/
select * from bankaccount

select accttype,count(accttype) as cnt from bankaccount where openedby = 'Teller' group by accttype order by cnt DESC limit 1
--ANSWER: checking

/*■■ In which branch do tellers open the most checking accounts for new customers?*/
select branch , count(accttype) as cnt from bankaccount where openedby ='Teller' and accttype ='Checking' and customer='New'
group by branch 
order by cnt DESC limit 1

--Answer: Central


