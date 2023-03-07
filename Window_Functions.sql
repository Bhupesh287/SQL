show databases;
use exmpractice;
show tables;

select * from emp;

############## OVER(Partition by _____) ################

select deptno, max(sal) from emp group by deptno;           #compressed output--->3 rows
select *, max(sal) over(partition by deptno) from emp;      #Expanded output--->all 14 rows

############## ROW_NUMBER() OVER() ##################

select *, row_number() over() from emp;                        #Assign Contineous Row_numbner--->1 2 3 4 5 6 7 8 9 10 11 12 13 14
select *, row_number() over(partition by deptno) from emp;     #Assign Dept wise Row_number--->(1 2 3) ( 1 2 3 4 5) (1 2 3 4 5 6)

#QUEURY--->Select 2 emp from each dept whose salary is highest.
select * from (select * , row_number() over(partition by deptno order by sal desc)
as rn from emp)x where x.rn < 3;                                                         #output---> (1 2) (1 2) (1 2)

############### RANK() OVER(Partition by ____) ################ for same values--> assign same rank & SKIP rank for next

select *, rank() over() from emp;                                              #Meaningless---->1 1 1 1 1 1 1 1 1 1 1 1 1
select *, rank() over(partition by deptno order by sal desc) from emp;         #output--->(1 2 3) (1 1 3 4 5) (1 2 3 4 4 6)

#QUEURY---->Select 2 emp from each dept whose salary is highest.
select * from (select * , rank() over(partition by deptno order by sal desc)
as rnk from emp)x where x.rnk < 3;                                             #output--->(1 2) (1 1) (1 2)

################ DENSE_RANK() ################# for same values--> assign same rank & DOES NOT SKIP rank for next

select *, dense_rank() over() from emp;                                        #Meaningless--->1 1 1 1 1 1 1 1 1 1 1 1 1 1
select *, dense_rank() over(partition by deptno order by sal desc) from emp;   #output--->(1 2 3) (1 1 2 3 4) (1 2 3 4 4 5)

#QUEURY---->Select 2 emp from each dept whose salary is highest.
select * from (select * , dense_rank() over(partition by deptno order by sal desc)
as drnk from emp)x where x.drnk < 3;                                           #output--->(1 2) (1 1 2) (1 2)

###############################################################################################################################################