create database windowsfunction;
use windowsfunction; 
create table employee (
Name	varchar(20),
Age int,
	Department varchar(20),
	Salary int);
 insert into employee (Name,age,department,salary)
 values 
 ("Ramesh",	20,	"Finance"	,50000),
  ("Deep"	,25,	"Sales"	,30000),
 ("Suresh",	22,	"Finance",	50000),
("Ram"	,28	,"Finance"	,20000),
("Pradeep"	,22,	"Sales"	,20000) ;


-- avg
select name,age,department,salary,avg(salary) over (partition by department order by age ) as avg_salary from employee;
select name,age,department,salary,avg(salary) over (partition by department) as avg_salary from employee; 


select name,age,department,salary, rank() over (partition by department order by salary desc) as empl_rank ,
dense_rank() over (partition by department order by salary desc) as empl_denserank,
row_number() over(partition by department order by salary  desc) as empl_row_number 
from employee;


select *,rank() over (partition by department order by salary desc) as empl_rank,
dense_rank() over (partition by department order by salary desc) as empl_dense,
row_number() over (partition by department order by salary desc)  as rrow_number 
from employee; 


-- window function 
select * from details; 
-- sum 
select * ,sum(current_inventory) over() as total_sum from details; 
-- sum
select *,sum(current_inventory) over (order by product_id rows between unbounded preceding and unbounded following) as Total_sum,
sum(current_inventory) over (order by product_id) as cumulative_sum from details; 

-- average
select *,avg(current_inventory) over (order by product_id rows between unbounded preceding and unbounded following) as avg_ ,
avg(current_inventory) over (order by product_id) as cumulative_avg from details; 

-- using partition by
select *,sum(current_inventory) over (partition by product_type order by product_id rows between unbounded preceding and unbounded following) as sum_ ,
sum(current_inventory) over (partition by product_type order by product_id) as cum_sum ,
sum(current_inventory) over (partition by product_type order by product_id rows between unbounded preceding and current row) as cum_sum2
from details ;


select *,avg(current_inventory) over (partition by product_type order by product_id rows between unbounded preceding and unbounded following) as avg_ ,
avg(current_inventory) over (partition by product_type order by product_id) as cum_avg ,
avg(current_inventory) over (partition by product_type order by product_id rows between unbounded preceding and current row) as cum_avg2
from details ; 

-- to find max,min 
select *,max(current_inventory) over (partition by product_type order by product_id rows between unbounded preceding and unbounded following) as max,
min(current_inventory) over (partition by product_type  order by product_id rows between unbounded preceding and unbounded following) as min  from details;

-- Lag function and lead function
select * ,lead(current_inventory) over (partition by product_type order by product_id rows between unbounded preceding and current row ) as sum,
lag((current_inventory))  over (partition by product_type order by product_id rows between unbounded preceding and unbounded following ) as preceding1 from details

