create table Science_class (
Enrollment_No int,
Name varchar,
Science_Mark int);

insert into Science_class values
(1,'Popeye',33),
(2,'Olive',54),
(3,'Brutus',98);

copy science_class from '/home/mahsa/Documents/code/sql_postgres/Data/Student.csv' delimiter ',' csv header; 

select name from Science_class where science_mark>60;

select * from Science_class where science_mark>30 and science_mark<60;

select * from Science_class where Not (science_mark>30 and science_mark<60);

update science_class set science_mark = 45 where name = 'Popeye';

delete from science_class where name='Robb';

alter table science_class RENAME COLUMN name to student_name;
select * from Science_class

