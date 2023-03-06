create database final_prep;
show databases;
use final_prep;
show tables;

-- table PEOPLE: containing unique ID and corresponding names.
CREATE TABLE PEOPLE (id INTEGER, name CHAR, salary int(20));
select * from people;

INSERT INTO PEOPLE VALUES(1, "A", 20000);
INSERT INTO PEOPLE VALUES(2, "B", 10000);
INSERT INTO PEOPLE VALUES(3, "C", 40000);
INSERT INTO PEOPLE VALUES(4, "D", 30000);

-- ADDRESS: containing the history of address information of each ID.
CREATE TABLE ADDRESS (id INTEGER, address varchar(50), updatedate date);
select * from address;

INSERT INTO ADDRESS VALUES(1, "address-1-1", "2016-01-01");
INSERT INTO ADDRESS VALUES(1, "address-1-2", "2016-09-02");
INSERT INTO ADDRESS VALUES(2, "address-2-1", "2015-11-01");
INSERT INTO ADDRESS VALUES(3, "address-3-1", "2016-12-01");
INSERT INTO ADDRESS VALUES(3, "address-3-2", "2014-09-11");
INSERT INTO ADDRESS VALUES(3, "address-3-3", "2015-01-01");
INSERT INTO ADDRESS VALUES(4, "address-4-1", "2010-05-21");
INSERT INTO ADDRESS VALUES(4, "address-4-2", "2012-02-11");
INSERT INTO ADDRESS VALUES(4, "address-4-3", "2015-04-27");
INSERT INTO ADDRESS VALUES(4, "address-4-4", "2014-01-01");


CREATE TABLE Emp (EmpNo INTEGER, Ename varchar(20), sal int(20), city varchar(20), DeptNo int(20));
select * from Emp;

INSERT INTO Emp VALUES(1, "ADAMS", 1000, 'Mumbai', 10);
INSERT INTO Emp VALUES(2, "BIAKE", 2000, 'Delhi', 10),(3, "ALLEN", 2500, 'Mumbai', 20),
(4, "KING", 3000, 'Delhi', 30),(5, "FORD", 4000, 'Mumbai', 40);

###################################################  NOTES  #####################################################

select * from people;

#Exponential operator
#in mysql ** cant work, here power(value,expo) work
select id,name ,salary, power(id,2) from people;

# ALIAS
select id, id*5 'alias1', name from people;   #Run successfully
select id, id*5 'alias1', name from people where alias1=5;   #error---we cant use alias in where clause
select id, id*5 'alias1', name from people where id*5=5;    #Run successfully

select * from address;

#to eliminate duplicate values
select distinct id from address;

############ ORDER BY clause ###########3
select id,address from address order by id;      #by default ascending order
select id,address from address order by id desc;  
select id,address from address order by id,address;     #it will 1st sort on id & if id has same 2 rows then it will sort it on address
select id,address from address order by id,address desc;
select id,address from address order by id desc,address desc;

select id,id*2 new_id, name from people order by new_id;  #we can use alias in order by clause
select id, name ,salary from people order by 2 desc;   #it will sort based on 2nd column
select * from people order by 3 desc;

-- flow of execution
# SELECT
# FROM
# WHERE
# GROUP BY
# HAVING
# ORDER BY

#WILDCHARD CHARACTER ('%'---unknown spaces '_'----single space) ----used for pattern matching
select * from Emp;
select * from Emp where Ename like 'A%';
select * from Emp where Ename like '%A';
select * from Emp where Ename like '%A%';
select * from Emp where Ename like '____';
select * from Emp where Ename like '__A%';

#BETWEEN operator------both are inclusive
select sal from Emp where sal between 2000 and 3000;
select sal from emp where sal>=2000 and sal<=3000;
							#These both queury gives same result, but between is faster than < > operators.

select Ename from Emp where Ename between 'A' and 'c';
select sal from Emp where sal not between 2000 and 3000;

#ANY & IN operator
select * from Emp where deptno=10 or deptno=20;
select * from Emp where DeptNo = any(10,20);    #ANY not works in mysql
select * from Emp where DeptNo in (10,20);
                                           # execution time--- IN < ANY < OR
                                           # IN is fastest but ANY is powerfull.
                                           #with IN we can check for 'IN' or 'NOT IN'
                                           #with ANY we can check =ANY  !=ANY  >=ANY  <=ANY <ANY 

                                           
										
########################SQL-FUNCTIONS############################
 
######## Character Functions ########
                                      #'||' is concatenation operator-------------but not works in MYSQL
select concat(ename,city) from emp;
select concat(concat(ename,' '), city) 'fun_in_fun' from emp;
select concat(ename,' ',city) from emp;
  
select upper(city) from emp; 
select lower(ename) from emp; 
  
                                            #index starts from 1
select ename,substr(ename,2) from emp;      #it will print string from 2nd char
select ename,substr(ename,2,3) from emp;    #2---starting postion     3---no.of char
select ename,substr(ename,-2) from emp;     #supports negative index
select ename,substr(ename,-3,2) from emp;
  
select ename,concat(upper(substr(ename,1,1)),lower(substr(ename,2))) from emp;  #Combination of CONCAT(), UPPER(), LOWER(), SUBSTR()

select ename, replace(ename,'A','B') from emp;

select ename, instr(ename,'A') from emp;      #gives the string position
                                              #it only take 2 parameters,here we cant provide starting position to search, it will automatically search from 1st index.

select ename, length(ename) from emp;

######## NUMBER FUNCTIONS ########
 
select * from people;
select tax,round(tax) from people;
select tax,round(tax,2) from people;
select tax,round(tax,-1) from people;
select tax,round(tax,-2) from people;
                                              #ROUND() & TRUNCATE() are same.
select tax,truncate(tax,1) from people;
select tax,truncate(tax,-2) from people;
  
select tax,ceil(tax) from people;            #ceiling
select tax,floor(tax) from people;                                              

select mod(5,2);
select sqrt(81);
select power(5,2);
select abs(-10);

######## DATE & TIME Functions ########

# 'YYYY-MM-DD' ----------by default

select sysdate();            #returns server current date & time
select now();                #returns server current date & time
select sysdate(),now(),sleep(2),sysdate(),now();
                             # SYSDATE() returns the time at which it executes. This differs from the behavior for NOW(), which returns a constant time that indicates the time at which the statement began to execute.
select * from address;
select datediff(sysdate(),updatedate) from address;    #returns the no. of days between two dates.
select dayname(sysdate());

######## LIST Function ########

select * from people;
insert into people(id,name) values(5,"z");

select * from people where salary=null;          #Any comparison done with null returns null.
select * from people where salary is null;       #Returns rows whose salary is null
select * from people where salary is not null;
select ifnull(salary,100) from people;           #it means if salary is null then returns 100 in that place.
select salary + ifnull(tax,100) total from people;
select ifnull(salary,100) + ifnull(tax,10) total from people;

select greatest(salary,20000) from people;       #it will compare each salary with 20000 and returns greatest from each salary.
select least(salary,20000) from people;          #it will compare each salary with 20000 and returns lowest from each salary.


######################### CASE Expression #####################

select * from people;

select case
when salary>20000 then 'Very Good'
when salary<20000 then 'Bad'
else 'Good'
end
from people;


######################### AGREEGATE Functions #####################

# NULL values are not counted in agreegate functions. otherwise that will affect to count(), avg().

select * from people;
select sum(salary) sum from people;
select avg(salary) average from people;
select min(salary) from people;
select max(salary) from people;
select count(salary) from people;
select count(*) from people;

select sum(salary)/count(*) from people;

select * from people where salary=min(salary);  #error---->we can't use agreegate func in where clause.

####################### GROUP BY Clause ########################
show databases;
use exmpractice;
show tables;
select * from customers;
select * from department;
select * from dept;
select * from emp;
select * from employees;
select * from orders;

select job, sum(sal) from emp group by job;
