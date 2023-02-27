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

#############################################  NOTES  ###########################################

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

#ORDER BY clause
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

# ANY & IN operator
select * from Emp where deptno=10 or deptno=20;
select * from Emp where DeptNo = any(10,20);    #ANY not works in mysql
select * from Emp where DeptNo in (10,20);
                                           # execution time--- IN < ANY < OR
                                           # IN is fastest but ANY is powerfull.
                                           #with IN we can check for 'IN' or 'NOT IN'
                                           #with ANY we can check =ANY  !=ANY  >=ANY  <=ANY <ANY 

