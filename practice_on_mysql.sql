show databases;
use practice;
show tables;
create table w3school(
id int(10),
name varchar(20),
salary int(20)
);
show tables;
select * from w3school;
insert into w3school values(1,'bhupesh',50000);
insert into w3school values(2,'rupesh',45000),(3,'raj',48000);
insert into w3school(id) values(4);
update w3school set name='vaish' where salary=48000;
update w3school set name='updated' where id=4;
update w3school set salary='10000';
delete from w3school where salary=10000;
SET SQL_SAFE_UPDATES = 0;

alter table w3school add column address varchar(20);
update w3school set address='kudal' where id=1;
update w3school set address='kankavli' where id=2;
update w3school set address='sawantwadi' where id=3;
SELECT id,name, CONCAT(salary,', ',address) AS SalAdd
FROM w3school; 
select * from w3school;
select * ,isnull('salary',500) from w3school;
select count(isnull(salary,0)) from w3school; 

Delimiter /
create procedure getallname()
begin
select name from w3school;
end /
Delimiter ; 

call getallname();

delimiter @
create procedure gets(IN abc varchar(10))
begin
select * from w3school where name=abc;
end @
delimiter ; 

call gets('bhupesh');