show databases;
use exmpractice;
show tables;
CREATE TABLE employee (id INTEGER, name varchar(50), email varchar(50), department varchar(50));
select * from employee;
drop table employee;
INSERT INTO EMPLOYEE VALUES(1, "Bhupesh", "bhupesh@gmail.com", "BSNL");
INSERT INTO EMPLOYEE VALUES(2, "Rupesh", "rupesh@gmail.com", "Airtel"),(3, "Raj", "raj@gmail.com", "Jio"),
(4, "Rupesh", "rupesh@gmail.com", "Airtel"),(5, "Raj", "Raj@gmail.com", "Idea");

select * from employees;
#######################################################################################################################
#Q1. Find 3rd highest salary.

#Using DISTINCT COUNT
select salary from employees e1 where 2 = (select count(distinct salary) from employees e2 where e2.salary > e1.salary);

#Using Subqueury
select max(salary) from employees where salary <(select max(salary) from employees where salary <(select max(salary) from employees));

#Using OFFSET,LIMIT
select salary from employees order by salary desc limit 2,1;

#######################################################################################################################

#Q2. Find out duplicate rows 

select * from employee;

select *, count(*) from employee group by email having count(*)>1;               #based on address

select *,count(*) from employee group by email,department having count(*)>1;        #based on address as well as hobbies

#######################################################################################################################

#Q3. Remove duplicate rows from the table.alter

#Using GROUP BY and HAVING with IN
delete from employee where id in 
(select id from 
      (select *,count(*) from employee group by email having count(*) > 1)
 as temp);
select * from employee;


#Using SELF JOIN
delete e1 from employee e1 inner join employee e2 where e1.email=e2.email and e1.id > e2.id;
select * from employee;

#######################################################################################################################