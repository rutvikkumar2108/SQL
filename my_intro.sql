show databases;
use customer1;

create database customer1;
show tables;

create table student(
id int not null,
firs_name varchar(20) not null,
las_name varchar(20) not null,
foreign key(id) references customer_info(id)
);
select * from customer_info;
desc customer_info;
drop table student;
create table student(
id int not null,
firs_name varchar(20) not null,
las_name varchar(20) not null,
foreign key(id) references customer_info(id)
);

insert into student values
(1,'rutu','kumar'),
(2,'he','jk');

select * from student;

create view rk as
select first_name,last_name from customer_info inner join student using (id);


select * from rk;
select * from customer_info;
select * from student;
alter table customer_info drop salary;
insert into customer_info values 
(3,'lk','gl',34),
(4,'sk','sj',35),
(5,'dj','aj',36);

select customer_info.id,customer_info.first_name,customer_info.last_name, student.firs_name  
from customer_info inner join student on customer_info.id=student.id;

select customer_info.id,customer_info.first_name,customer_info.last_name, student.firs_name  
from customer_info left join student on customer_info.id=student.id;

select customer_info.id,customer_info.first_name,customer_info.last_name, student.firs_name  
from customer_info right join student on customer_info.id=student.id;

select customer_info.id,customer_info.first_name,customer_info.last_name, student.firs_name  
from customer_info left join student on customer_info.id=student.id
union
select customer_info.id,customer_info.first_name,customer_info.last_name, student.firs_name  
from customer_info right join student on customer_info.id=student.id;

select customer_info.id,customer_info.first_name,customer_info.last_name, student.firs_name  
from customer_info cross join student;

create table department(
id int not null,
salary int not null,
year_info int not null,
foreign key(id) references customer_info(id)
);
drop table department;
insert into department values 
(1,'200','1010'),
(2,'300','2020');

select customer_info.id, customer_info.first_name,customer_info.last_name,student.firs_name, 
department.salary, department.year_info from (
select customer_info.id,customer_info.first_name,customer_info.last_name, student.firs_name  
from customer_info inner join student on customer_info.id=student.id
) inner join department on department.id=customer_info.id;

select customer_info.id, customer_info.first_name,customer_info.last_name,student.firs_name from
(select customer_info.id,customer_info.first_name,customer_info.last_name, student.firs_name  
from customer_info inner join student on customer_info.id=student.id
);

with raw as (
select customer_info.id,customer_info.first_name,customer_info.last_name, student.firs_name  
from customer_info inner join student on customer_info.id=student.id
)

select * from raw;

call get_customer_info(25);

call get_info(@records);
select @records as Totalrecords;

select * from customer_info;

create database company_data;
use company_data;

create table employee_table(
empid int not null primary key auto_increment,
first_name varchar(20) not null,
last_name varchar(20) not null,
salary int not null,
joining_date datetime,
department varchar(20)
);

create table bonus(
empid int not null,
bonus_amount int not null,
bonus_date datetime,
foreign key (empid) references employee_table(empid)
on Delete cascade
);

create table designation(
empid int not null,
designation varchar(20) not null,
designation_date datetime,
foreign key(empid) references employee_table(empid) on delete cascade 
);

insert into employee_table values
(1,'krish','naik',50000,'14-12-11','development'),
(2,'sanket','kumar',40000,'13-12-11','development'),
(3,'satish','kumar',30000,'12-12-11','HR'),
(4,'satish','kumar',20000,'11-12-11','HR');

insert into bonus values
(1,5000,'17-03-14'),
(2,5000,'16-03-13'),
(3,5000,'16-03-15'),
(4,5000,'16-03-17');

insert into designation values
(1,'manager','2016-02-05'),
(2,'executive','2016-06-11'),
(3,'executive','2016-06-11'),
(4,'manager','2016-06-11');

select * from employee_table;
select * from bonus;
select * from designation;

select * from employee_table where first_name like 'k%';
select * from employee_table where salary>10000 and salary<35000;
select concat(first_name," ",last_name) as employee_name,salary from employee_table where empid in
(select empid from employee_table where salary between 10000 and 35000);
select * from employee_table where joining_date > '14-12-01';
select * from employee_table where year(joining_date)=2014 and month(joining_date)=12;
select count(*) from employee_table group by department;

select * from employee_table inner join designation
on employee_table.empid=designation.empid
where designation.designation='executive';

select * from transactions_1;
create table chargebacks(
trans_id int,
charge_date date,
foreign key(trans_id) references transactions_1(id)
);

insert chargebacks values 
(102,'2019-05-29'),
(101,'2019-06-30'),
(105,'2019-09-18');
select * from chargebacks;

with t1 as(
select trans_id,concat(year(chargebacks.charge_date),'-',month(chargebacks.charge_date)) as month,country,
count(trans_id) as chargebacks_count,sum(amount) as chargebacks_amount from chargebacks 
left join transactions_1 on chargebacks.trans_id=transactions_1.id 
group by month,country
),

t2 as (
select id,concat(year(transactions_1.trans_date),'-',month(transactions_1.trans_date)) as month,
country, count(state) as approved_count, sum(amount) as approved_amount
from transactions_1 where state='approved' group by month,country
)

select t1.month, t1.country, t1.chargebacks_count,t2.approved_count, t2.approved_amount,
t1.chargebacks_amount from t1 left join t2 on t1.month=t2.month;




create table queries(
query_name varchar(25),
result varchar(25),
position int,
rating int
);

insert queries values
('dog','kaka',1,5),
('dog','papa',2,5),
('dog','nana',200,1),
('cat','amma',5,2),
('cat','mama',3,3),
('cat','maam',7,4);

with t1 as (
select *, (rating/position) as ratio from queries group by result
)
select query_name, round(sum(ratio)/count(result),2) as quality, round(1/count(ratio)*100,2) as per from t1 group by query_name;



create table teams (
id int primary key,
name varchar(25)
);

create table matches_1(
match_id int primary key,
host_team int,
guest_team int,
host_goal int,
guest_goal int
);

insert teams values
(10,'lfc'),
(20,'nfc'),
(30,'afc'),
(40,'cfc'),
(50,'tfc');

insert matches_1 values
(1,10,20,3,0),
(2,30,10,2,2),
(3,10,50,5,1),
(4,20,30,1,0),
(5,50,30,1,0);

select teams.id,teams.name , 
sum(case when teams.id=matches_1.host_team and host_goal>guest_goal then 3 
         when teams.id=matches_1.host_team and host_goal=guest_goal then 1
         when teams.id=matches_1.guest_team and host_goal<guest_goal then 3
         when teams.id=matches_1.guest_team and host_goal=guest_goal then 1
         else 0 end) 
as num_points from teams left join matches_1 on teams.id=matches_1.host_team or teams.id = matches_1.guest_team
group by teams.id;


create table failed (
fail_date date primary key
);

create table succeeded(
success_date date primary key
);

insert failed values
('2018-12-28'),
('2018-12-29'),
('2019-01-04'),
('2019-01-05');

insert succeeded values 
('2018-12-30'),
('2018-12-31'),
('2019-01-01'),
('2019-01-02'),
('2019-01-03'),
('2019-01-06');


with t1 as (
select fail_date from failed where fail_date between '2019-01-01' and '2019-12-31' order by fail_date
),

t2 as (
select success_date from succeeded where success_date between '2019-01-01' and '2019-12-31' order by success_date
)
select (case when min(t2.success_date)<min(t1.fail_date) then min(t2.success_date) else min(t1.fail_date) end) as 
start_date, (case when (case when min(t2.success_date)<min(t1.fail_date) then min(t2.success_date) else min(t1.fail_date) end)=min(t2.success_date) 
             then (select min(success_date) from (select success_date from t2 having success_date>(case when min(t2.success_date)<min(t1.fail_date) then min(t2.success_date) else min(t1.fail_date) end
             )) as tb)
             else (select min(fail_date) from (select fail_date from t2 having fail_date>(case when min(t2.success_date)<min(t1.fail_date) then min(t2.success_date) else min(t1.fail_date) end
             )) as kv) end
			 )as end_date , (case when (case when min(t2.success_date)<min(t1.fail_date) then min(t2.success_date) else min(t1.fail_date) end)=min(t2.success_date)then 'succeeded' else 'failed' end)
             as period_state 
             from t1,t2;

 create table friend(
 user1_id int,
 user2_id int 
 );
 
 create table likes(
 user_id int,
 page_id int
 );
 
 insert friend values 
 (1,2),
 (1,3),
 (1,4),
 (2,3),
 (2,4),
 (2,5),
 (6,1);
 
 insert likes values
 (1,88),
 (2,23),
 (3,24),
 (4,56),
 (5,11),
 (6,33),
 (2,77),
 (3,77),
 (6,88);
 
 
 select distinct page_id from likes where user_id in (
 select user2_id as user from friend where user1_id=1
 union 
 select user1_id as user from friend where user2_id=1
 ) and page_id not in ( select page_id from likes where user_id=1);
 
 
 create table employeee (
 employee_id int primary key,
 employee_name varchar(25),
 manager_id int
);

insert employeee values
(1,'dsdjd',1),
(3,'dhdd',3),
(2,'rhryh',1),
(4,'hhh',2),
(7,'jjg',4),
(8,'hhhj',3),
(9,'swjswjwj',8),
(77,'ajaja',1);


select employee_id from employeee where manager_id in
(select employee_id from employeee where manager_id in 
(select employee_id as manager_id from employeee where manager_id=1)) and employee_id!=1;


create table students(
student_id int primary key,
student_name varchar(26)
);

create table subjects(
subject_name varchar(25)
);


create table examinations(
student_id int,
subject_name varchar(25)
);

insert students values
(1,'alice'),
(2,'bob'),
(13,'john'),
(6,'alex');

insert subjects values
('math'),('physics'),('programming');

insert examinations values 
(1,'math'),
(1,'physics'),
(1,'programming'),
(2,'programming'),
(1,'physics'),
(1,'math'),
(13,'math'),
(13,'programminng'),
(13,'physics'),
(2,'math'),
(1,'math');



select students.student_id, students.student_name, subjects.subject_name, count(examinations.student_id) from students join subjects
left join examinations on 
students.student_id=examinations.student_id and subjects.subject_name=examinations.subject_name
group  by students.student_id,subject_name;



create table logs
(log_id int primary key);

insert logs values 
(1),(2),(3),(7),(8),(10);

select rank() over(order by log_id) as tk from logs;

select t1.log_id as start_id ,t2.log_id from logs as t1 left join logs as t2 
on t1.log_id=t2.log_id-1;

select rank() over(order by log_id) as rk from logs;

create table countries(
country_id int primary key,
country_name varchar(25)
);

create table weather(
country_id int,
weather_state int,
day date
);

insert countries values
(2,'usa'),
(3,'austrlia'),
(7,'peru'),
(5,'china'),
(8,'moroco'),
(9,'spain');

insert weather values
(2,15,'2019-11-01'),
(2,12,'2019-10-28'),
(2,12,'2019-10-27'),
(3,-2,'2019-11-10'),
(3,0,'2019-11-11'),
(3,3,'2019-11-12'),
(5,16,'2019-11-07'),
(5,18,'2019-11-09'),
(5,21,'2019-11-23'),
(7,25,'2019-11-28'),
(7,22,'2019-12-01'),
(7,20,'2019-12-02'),
(8,25,'2019-11-05'),
(8,27,'2019-11-15'),
(8,31,'2019-11-25'),
(9,7,'2019-10-23'),
(9,3,'2019-12-23');

select country_name, (case when state <=15 then 'cold'
                           when state >=25 then 'hot'
                           else 'warm' end) as weather_type from (
select country_name, round(sum(weather_state)/count(weather_state),2) as state from countries 
left join weather on countries.country_id=weather.country_id 
where month(weather.day)=11 group by countries.country_id
) as pk;

create table employeeee(
employee_id int primary key,
team_id int
);

insert employeeee values
(1,8),
(2,8),
(3,8),
(4,7),
(5,9),
(6,9);

select employee_id, team as team_size from employeeee join(
select team_id, count(team_id) as team from employeeee group by team_id 
 ) as l on employeeee.team_id=l.team_id;
 
 create table scores(
 gender varchar(23),
 day date,
 score_points int
 );
 
 insert scores values
 ('f','2020-01-01',17),
 ('f','2020-01-07',23),
 ('m','2020-01-07',7),
 ('m','2019-12-25',11),
 ('m','2019-12-30',13),
 ('m','2019-12-31',3),
 ('m','2019-12-18',2),
 ('f','2019-12-31',23),
 ('f','2019-12-30',17);
 
 select gender,day, sum(score_points) over (partition by gender order by day)as total from scores;
 
 
 create table customer(
 id int primary key,
 visited_on date,
 amount int);
 
 insert customer values
 (1,'2019-01-01',100),
 (2,'2019-01-02',110),
 (3,'2019-01-03',120),
 (4,'2019-01-04',130),
 (5,'2019-01-05',110),
 (6,'2019-01-06',140),
 (7,'2019-01-07',150),
 (8,'2019-01-08',80),
 (9,'2019-01-09',110),
 (10,'2019-01-10',130),
 (11,'2019-01-10',150);
 
 select visited_on, sum(amount) over (order by visited_on rows 6 preceding) from customer;
 
 
 create table ads(
 ad_id int,
 user_id int,
 action varchar(12)
 );
 
 insert ads values
 (1,1,'clicked'),
 (2,2,'clicked'),
 (3,3,'viewed'),
 (5,5,'ignored'),
 (1,7,'ignored'),
 (2,7,'viewed'),
 (3,5,'clicked'),
 (1,4,'viewed'),
 (2,11,'viewed'),
 (1,2,'clicked');
 
 select ad_id,sum(case when action='clicked' then 1 else 0 end) as k from ads group by ad_id;
 select sum(case when action='clicked' then 1 
                 when action='viewed' then 1 else 0 end) as m from ads group by ad_id;
 select ad_id, sum(case when action='clicked' then 1 else 0 end)/sum(case when action='clicked' then 1 
                                                                          when action='viewed' then 1 else 0 end) *100
as ctr from 
ads group by ad_id;

drop table visits;
create table visits(
user_id int,
visit_date date);
create table transactions_2(
user_id int,
transactions_date date,
amount int);

insert visits  values
(1,'2020-01-01'),
(2,'2020-01-02'),
(12,'2020-01-01'),
(19,'2020-01-03'),
(1,'2020-01-02'),
(2,'2020-01-03'),
(1,'2020-01-04'),
(7,'2020-01-11'),
(9,'2020-01-25'),
(8,'2020-01-28');

insert transactions_2 values
(1,'2020-01-02',120),
(2,'2020-01-03',22),
(7,'2020-01-11',232),
(1,'2020-01-04',7),
(9,'2020-01-25',33),
(9,'2020-01-25',66),
(8,'2020-01-28',1),
(9,'2020-01-25',99);

with t1 as (
select visits.user_id, visit_date, transactions_2.user_id as t_id, transactions_date,
count(transactions_date) over(partition by transactions_date) as count
from visits left join transactions_2
on visits.user_id=transactions_2.user_id and
visits.visit_date=transactions_2.transactions_date
),
t2 as (
select * from t1 group by 1,2,3,4,5
)
select count(transactions_date) as transactions_count, count(visit_date) as visits_count from t2
where transactions_date is null
union all
select count as transactions_count, count(visit_date) as visits_count from t2
where count=1
union all
select coalesce(count,2)  as transactions_count, coalesce(count(visit_date),0) as visit_count
from t2 where count=2
union all
select count as transactions_count, count(visit_date) as visits_count from t2
where count=3;


with p1 as (
with t1 as(
select count(*) as visit_count,user_id, visit_date 
from visits group by visit_date,user_id
),
t2 as (
select count(*) transactions_count,user_id, transactions_date from
 transactions_2 group by transactions_date
 )
 select visit_count,  transactions_count,t1.user_id,visit_date from
 t1 left join t2 on visit_date=transactions_date and t1.user_id = t2.user_id
)
select (case when transactions_count=0 then 0 else p1.transactions_count end) as transactions_count,
sum(visit_count) as visits_count from p1 group by transactions_count;

create table departments_01(
id int primary key,
name varchar(28)
);

create table students_01(
id int primary key,
name varchar(28),
department_id int);

insert departments_01 values
(1,'EE'),
(7,'CE'),
(13,'BM');

insert students_01 values
(23,'a',1),
(1,'b',7),
(5,'c',13),
(2,'d',14),
(4,'e',77),
(3,'f',74),
(6,'g',1),
(8,'h',7),
(7,'i',33),
(11,'j',1);

select students_01.id, students_01.name from students_01  left join departments_01 
on departments_01.id= students_01.department_id where departments_01.name is null;

create table friends(
id int primary key,
name varchar(23),
activity varchar(20)
);
create table activities(
id int primary key,
name varchar(29)
);

insert friends values
(1,'a','eating'),
(2,'b','singing'),
(3,'c','singing'),
(4,'d','eating'),
(5,'e','eating'),
(6,'f','riding');


insert activities values
(1,'eating'),
(2,'singing'),
(3,'riding');

with t1 as (
select activities.id, activities.name, count(friends.activity) as count from activities
left join friends on activities.name=friends.activity group by activities.name
)
select name from t1 where t1.count not in (
select max(count) as range_count from t1
union
select min(count) as range_count from t1
);




with t1 as (
select activities.id, activities.name, count(friends.activity) as count from activities
left join friends on activities.name=friends.activity group by activities.name
)

select max(count) from t1
union
select min(count) from t1;







select name from 
(
select activities.id, activities.name, count(friends.activity) as count from activities
left join friends on activities.name=friends.activity group by activities.name
)
as t1 where min(count) < t1.count < max(count);



create table customers(
customer_id int primary key,
customer_name varchar(29)
);

create table  contacts(
user_id int,
contact_name varchar(29)
);

create table invoices(
invoice_id int primary key,
price int,
user_id int
);

insert customers values
(1,'alice'),
(2,'bob'),
(13,'jhon'),
(6,'alex');

insert contacts values 
(1,'bob'),
(1,'jhon'),
(1,'jal'),
(2,'omar'),
(2,'meir'),
(6,'alice');

insert invoices values 
(77,100,1),
(88,200,1),
(99,300,2),
(66,400,2),
(55,500,13),
(44,60,6);

with p1 as (
with t1 as(
select invoice_id, customer_name, price, user_id from invoices left join
customers on user_id=customer_id
)

select invoice_id, customer_name, price, t1.user_id, count(contacts.user_id) as contacts_cnt
from t1 left join contacts on t1.user_id=contacts.user_id group by invoice_id
),
p2 as (
select user_id, contact_name from contacts 
join customers where contacts.contact_name in (customers.customer_name)
)
select invoice_id, customer_name, price,contacts_cnt,count(p2.user_id) from p1
left join p2 on p1.user_id=p2.user_id group by invoice_id;



create table useractivity(
name varchar(20),
activity varchar(90),
start_date date,
end_date date
);

insert useractivity values
('alice','travel','2020-02-12','2020-02-20'),
('alice','dancing','2020-02-21','2020-02-23'),
('alice','travel','2020-02-24','2020-02-28'),
('bob','travel','2020-02-11','2020-02-18');


select name, activity, max(start_date), max(end_date) from useractivity group by name;

create table product(
product_id int primary key,
product_name varchar(28)
);


create table sales(
product_id int primary key,
period_start date,
period_end date,
average_daily_sales int
);

insert product values
(1,'LC phone'),
(2,'LC t-shirt'),
(3,'LC keychain');

insert sales values
(1,'2019-01-25','2019-02-28',100),
(2,'2018-12-01','2020-01-01',10),
(3,'2019-12-01','2020-01-31',1);


select product_id,
(case when year(period_start)=year(period_end) then year(period_start)
	  when year(period_start)+1=year(period_end) then
     (year(period_start) and year(period_start)+1)
      when year(period_start)+2=year(period_end) then (year(period_start) and year(period_start)+1 and year(period_start)+2)
      else 0 end) as report_year,
average_daily_sales,
(case when year(period_start)=year(period_end) then datediff(period_end,period_start) else 0 end) as days
from sales group by product_id,report_year;


with p1 as (
select product_id, report_year, average_daily_sales*days as total_amount from (
select product_id,  year(period_start) as report_year,
average_daily_sales, datediff(period_end,period_start)+1 as days from sales where year(period_start)=year(period_end)
union
select product_id,  year(period_start) as report_year,
average_daily_sales, 366-dayofyear(period_start) as days from sales where year(period_start)+1=year(period_end)
union
select product_id, year(period_start)+1  as report_year, 
average_daily_sales, dayofyear(period_end) as days from sales where year(period_start)+1=year(period_end)
union
select product_id,  year(period_start) as report_year,
average_daily_sales, 366-dayofyear(period_start) as days from sales where year(period_start)+2=year(period_end)
union
select product_id, year(period_start)+1  as report_year, 
average_daily_sales, 365 as days from sales where year(period_start)+2=year(period_end)
union
select product_id, year(period_start)+2  as report_year, 
average_daily_sales, dayofyear(period_end) as days from sales where year(period_start)+2=year(period_end)
) as k group by product_id,report_year
)

select p1.product_id, product_name, report_year, total_amount from p1 left join 
product on p1.product_id=product.product_id;



create table stocks(
name varchar(24),
operation varchar(23),
day int,
price int);

insert stocks values
('lc','buy',1,1000),
('ck','buy',2,10),
('lc','sell',5,9000),
('hb','buy',17,30000),
('ck','sell',3,1010),
('ck','buy',4,1000),
('ck','sell',5,500),
('ck','buy',6,1000),
('hb','sell',29,7000),
('ck','sell',10,10000);

with p1 as (
select name, operation, sum(price) as sale from stocks group by name,operation)

select name as stock_name , 
(select sale from p1 where operation='sell' and name=stock_name)-(select sale from p1 where operation='buy' and name=stock_name) as capital_gain_loss
from p1 group by name;


create table customers_2(
id int ,
name varchar(23)
);

create table orders(
order_id int primary key,
id int,
product_name varchar(25)
);

insert customers_2 values
(1,'dan'),
(2,'dia'),
(3,'eli'),
(4,'jhon');

insert orders values
(1,1,'a'),
(2,1,'b'),
(3,1,'d'),
(4,1,'c'),
(5,2,'a'),
(6,3,'a'),
(7,3,'b'),
(8,3,'d'),
(9,4,'c');

with p1 as (
select  id from orders where product_name='a' and 
id in (
select  id from orders where product_name='b'
))
select p1.id from p1 where p1.id not in (select id from orders where product_name='c');

create table student_3(
id int primary key,
name varchar(298)
);

create table exam(
exam_id int,
id int,
score int);

insert student_3 values
(1,'dani'),
(2,'jade'),
(3,'stella'),
(4,'jon'),
(5,'will');

insert exam values
(10,1,70),
(10,2,80),
(10,3,90),
(20,1,80),
(30,1,80),
(30,3,80),
(30,4,90),
(40,1,60),
(40,2,70),
(40,4,80);


with p1 as (
select exam_id, max(score) as max_score from exam group by exam_id
),
p2 as (
select exam_id, min(score) as min_score from exam group by exam_id
),
p3 as (
select id  from exam right join p1 on exam.exam_id=p1.exam_id and exam.score=p1.max_score
),
p4 as (
select id  from exam right join p2 on exam.exam_id=p2.exam_id and exam.score=p2.min_score
)
select id from exam where id not in (select id from p3)
and id not in (select id from p4) group by id;

with p1 as ( 
select * from exam where id not in 
(
select id from exam right join (
select exam_id, max(score) as max from exam group by exam_id) as c 
on exam.exam_id=c.exam_id and exam.score=c.max
)
and 
id not in (
select id from exam right join (
select exam_id, min(score) as min from exam group by exam_id) as c 
on exam.exam_id=c.exam_id and exam.score=c.min
)
)
select p1.id, name from p1 left join student_3 on p1.id=student_3.id group by p1.id;


create table npv(
id int,
year int,
npv int);

create table queries(
id int,
year int);

insert npv values
(1,2018,100),
(7,2020,30),
(13,2019,40),
(1,2019,113),
(2,2008,121),
(3,2009,12),
(11,2020,99),
(7,2019,0);

insert queries values
(1,2019),(2,2008),(3,2009),(7,2018),(7,2019),(7,2020),(13,2019);


select queries.id, queries.year, coalesce(npv.npv,0) as npv from queries left join npv on 
npv.id=queries.id and npv.year=queries.year group by queries.id,queries.year;

create table sessions(
id int,
duration int);

insert sessions values
(1,30),
(2,299),
(3,340),
(4,580),
(5,1000);

select count(id) as total from(
select id, duration/60 as minutes from sessions)
where minutes between 0 and 5;

with p1 as(
select id, duration/60 as minutes from sessions
) 
select count(id) as total from p1 where minutes between 0 and 5;

create table variables(
name varchar(2),
value int
);

create table expressions(
left_ varchar(3),
operator varchar(2),
right_ varchar(3)
);

insert variables values
('x',66),
('y',77);

insert expressions values
('x','>','y'),
('x','<','y'),
('x','=','y'),
('y','>','x'),
('y','<','x'),
('x','=','x');

with p2 as (
with p1 as (
select left_,value as value_left,operator,right_ from expressions
left join variables on expressions.left_=variables.name
)

select left_, value_left,operator,right_, value as value_right from p1
left join variables on p1.right_=variables.name
)

select left_, operator, right_, 
(case when operator='>' then (case when value_left > value_right then 'true' else 'false' end)
	  when operator='<' then (case when value_left < value_right then 'true' else 'false' end)
      when operator='=' then (case when value_left = value_right then 'true' else 'false' end)
      else 'false' end) as value from p2;

create table sales_1(
sale_date date,
fruit varchar(27),
sold_num int);


insert sales_1 values
('2020-05-01','apples',10),
('2020-05-01','oranges',8),
('2020-05-02','apples',15),
('2020-05-02','oranges',15),
('2020-05-03','apples',20),
('2020-05-03','oranges',0),
('2020-05-04','apples',15),
('2020-05-04','oranges',16);

with p1 as (
select sale_date, sold_num as apple_num from sales_1 where fruit='apples' group by sale_date
),
p2 as (
select sale_date, sold_num as orange_num from sales_1 where fruit='oranges' group by sale_date
)  

select p1.sale_date, apple_num-orange_num as diff from p1 left join p2 
on p1.sale_date=p2.sale_date;


create table logins(
id int,
date date);

insert logins values
(7,'2020-05-30'),
(1,'2020-05-30'),
(7,'2020-05-31'),
(7,'2020-06-01'),
(7,'2020-06-02'),
(7,'2020-06-02'),
(7,'2020-06-03'),
(1,'2020-06-07'),
(7,'2020-06-10');

with t1 as (
select id, date from logins group by id,date order by id,date)
select id, lead(date,1) over(partition by id order by date) as new_login from t1;

select t1.id,t1.date,datediff(t1.date,t2.date) from logins as t1 inner join logins as t2 on t1.id=t2.id and
datediff(t1.date,t2.date)
between 1 and 4 group by t1.id, t1.date
having count(distinct(t2.date))=4;

select id, date, lead(date,4) over(partition by id order by date) as date_5
from (select distinct * from logins) b;

with p1 as (
select id, date+1 as new_date from(
select distinct id, date from logins order by id,date) b
),
p2 as (
select distinct id, date from logins order by id,date)

select p2.id, date-new_date as diff from p1 left join p2 on p2.id=p1.id and p2.date=p1.new_date;



with p1 as 
(
select id, date from logins order by id,date)
select id, date+1 as new_date from p1;

create table points(
id int,
x_value int,
y_value int
); 

insert points value
(1,2,8),
(2,4,7),
(3,2,10);


select p1,p2,area from (
select t1.id as p1, t2.id as p2, abs(t1.x_value-t2.x_value)*abs(t1.y_value-t2.y_value) as area
from points t1 left join points t2 on t1.id<t2.id having p2 is not null order by area desc) d
where area!=0;


create table salaries(
company_id int,
employee_id int,
employee_name varchar(29),
salary int);

insert salaries values
(1,1,'tony',2000),
(1,2,'pro',21300),
(1,3,'tyroo',10800),
(2,1,'pam',300),
(2,7,'basse',450),
(2,9,'heri',700),
(3,7,'boc',100),
(3,2,'ogn',2200),
(3,13,'nyan',3300),
(3,15,'morni',1866);




with p2 as ( 
with p1 as (
select company_id, max(salary) as maxu from salaries group by company_id
)
select salaries.company_id,employee_id,employee_name,salary,p1.maxu from salaries
left join p1 on salaries.company_id=p1.company_id group by company_id,employee_id) 
select company_id,employee_id,employee_name, (case when p2.maxu<1000 then salary
                                                   when p2.maxu between 1000 and 10000 then 0.76*salary
                                                   when p2.maxu>10000 then 0.51*salary 
                                                   else 0 end) as salary from p2
                                                   

 group by company_id,employee_id;


create table orders_03(
order_id int primary key,
customer_id int,
order_date date,
item_id int,
quantity int);

create table items(
item_id int primary key,
item_name varchar(20),
item_cat varchar(90)
);

insert orders_03 values
(1,1,'2020-06-01',1,10),
(2,1,'2020-06-08',2,10),
(3,2,'2020-06-02',1,5),
(4,3,'2020-06-03',3,5),
(5,4,'2020-06-04',4,1),
(6,4,'2020-06-05',5,5),
(7,5,'2020-06-05',1,10),
(8,5,'2020-06-14',4,5),
(9,5,'2020-06-21',3,5);

insert items values
(1,'abook','book'),
(2,'dbook','book'),
(3,'lphone','phone'),
(4,'cphone','phone'),
(5,'lglass','glasses'),
(6,'tshirt','shirt');


select orders_03.*, item_cat ,dayname(order_date) as day from orders_03 left join items on
orders_03.item_id=items.item_id;

with p2 as (
with p1 as (
select  day, item_cat,sum(quantity) as qn from 
(select orders_03.*, item_cat ,dayname(order_date) as day from orders_03 left join items on
orders_03.item_id=items.item_id) b group by day,item_cat
)
select item_cat,(case when day='Monday' then sum(qn) else 0 end) as monday,
				(case when day='Tuesday' then sum(qn) else 0 end) as tuesday,  
                (case when day='Wednesday' then sum(qn) else 0 end) as wednesday,
                (case when day='Thursday' then sum(qn) else 0 end) as thursday,
                (case when day='Friday' then sum(qn) else 0 end) as Friday,
                (case when day='Saturday' then sum(qn) else 0 end) as saturday,
                (case when day='Sunday' then sum(qn) else 0 end) as sunday
       from p1 group by day,item_cat
)

select item_cat, sum(monday) as monday,sum(tuesday) as tuesday, sum(wednesday) as wednesday,
sum(thursday) as thursday, sum(Friday) as friday, sum(saturday) as saturday, sum(sunday) as sunday
from p2 group by item_cat;


create table activities_01(
sell_date date,
product varchar(23)
);

insert activities_01 values
('2020-05-30','headphone'),
('2020-06-01','pencil'),
('2020-06-02','mask'),
('2020-05-30','basketball'),
('2020-06-01','bible'),
('2020-06-02','mask'),
('2020-05-30','shirt');

select sell_date, count(distinct product) as num_sold,
 group_concat(distinct product) as products from activities_01 group by sell_date;


create table person_01(
id int primary key,
name varchar(23),
ph_number varchar(20)
);

create table country_02(
name varchar(20),
code varchar(10)
);

create table calls(
caller_id int,
callee_id int,
duration int
);

insert person_01 values
(3,'joj','051-1234567'),
(12,'elvis','051-7654321'),
(1,'mon','212-1234567'),
(2,'mar','212-6523651'),
(7,'meir','972-1234567'),
(9,'rachel','972-0011100');

insert country_02 values
('peru','051'),
('israel','952'),
('morocco',212),
('germany','049'),
('ethiopia','251');

insert calls values
(1,9,33),
(2,9,4),
(1,2,59),
(3,12,102),
(3,12,330),
(12,3,5),
(7,9,13),
(7,1,3),
(9,7,1),
(1,7,7);

with p7 as(
with p4 as(
with p3 as(
with p1 as(
select caller_id, sum(duration) as duration, count(duration) as qn from calls group by caller_id
),
p2 as (
select callee_id, sum(duration) as duration, count(duration) as qn from calls group by callee_id
)
select p1.caller_id, p1.duration+p2.duration as dur, p1.qn+p2.qn as Qn from p1 left join p2 on
p1.caller_id=p2.callee_id group by p1.caller_id
)

select caller_id,dur,Qn,substring(ph_number from 1 for 3) as con from p3 left join person_01 on person_01.id=p3.caller_id
),

p5 as(
select con, sum(dur)/sum(Qn) as avg from p4 group by con
),

p6 as 
(
select sum(dur)/sum(Qn) as global_average from p4
)

select con from p5,p6 where p5.avg>p6.global_average
)

select name from country_02 right join p7 on country_02.code=p7.con;

create table customers_03(
id int,
name varchar(24)
);

create table orders_04(
order_id int,
order_date date,
customer_id int);

insert customers_03 values
(1,'wis'),
(2,'jon'),
(3,'anna'),
(4,'mar'),
(5,'khaled');


insert orders_04 values
(1,'2020-07-31',1),
(2,'2020-07-30',2),
(3,'2020-07-31',3),
(4,'2020-07-29',4),
(5,'2020-06-10',1),
(6,'2020-08-01',2),
(7,'2020-08-01',3),
(8,'2020-08-03',1),
(9,'2020-08-07',2),
(10,'2020-07-15',1);

select customer_id,order_id,order_date, row_number() over(partition by customer_id order by order_date rows 3 preceding) as km
from  orders_04;

create table orders_05
(id int,
order_date date,
customer_id int,
product_id int
);

insert orders_05 values
(1,'2020-07-31',1,1),
(2,'2020-07-30',2,2),
(3,'2020-08-29',3,3),
(4,'2020-07-29',4,1),
(5,'2020-06-10',1,2),
(6,'2020-08-01',2,1),
(7,'2020-08-01',3,3),
(8,'2020-08-03',1,2),
(9,'2020-08-07',2,3),
(10,'2020-07-15',1,2);

with t1 as (
with p1 as (
select customer_id, product_id, count(*) as count from orders_05 group by 1,2 order by customer_id
)
select customer_id,product_id,count, rank() over(partition by customer_id order by count desc) as rk 
from p1
)
select customer_id, product_id from t1 where count>1 
union all
select customer_id, product_id from t1 where count=1 and rk=1 order by customer_id;

with p1 as(
select product_id,id, customer_id, order_date, rank() over(partition by product_id order by order_date desc) as rk
from orders_05 group by product_id,id,customer_id)
select product_id,customer_id,order_date from p1 where rk=1;

create table customer_0001(
id int,
name varchar(20)
);
insert customer_0001 values
(1,'alice'),
(4,'bob'),
(5,'charlie');

with recursive cte as(
select 1 as id, max(c.id) as max_id from customer_0001 c
union all
select id+1, max_id from cte where id<max_id
)
select id as ids from cte c where c.id not in (select id from customer_0001)
order by 1 asc;

create table users_04(
user_id int,
user_name varchar(9),
credit int
);

create table transactions_04(
trans_id int,
paid_by int,
paid_to int,
amount int);

insert users_04 values
(1,'mou',100),
(2,'jon',200),
(3,'win',10000),
(4,'luis',800);

insert transactions_04 values
(1,1,3,400),
(2,3,2,500),
(3,2,1,200);
with p2 as (
with p1 as (
select user_id, user_name, (case when b.amount is not null then a.credit-b.amount else a.credit end)
as credit from users_04 a left join transactions_04 b on a.user_id=b.paid_by group by user_id
)
select user_id,user_name, (case when c.amount is not null then p1.credit+c.amount else p1.credit end) 
as credit from p1 left join transactions_04 c on p1.user_id=c.paid_to group by user_id
)
select user_id, user_name, credit, (case when credit<0 then 'YES' else 'NO' end) as credit_limit_reached
from p2;

 create table visits_05(
 visit_id int,
 customer_id int
 );
 
create table transactions_05(
id int,
visit_id int,
amount int
);

insert visits_05 values
(1,23),
(2,9),
(4,30),
(5,54),
(6,96),
(7,54),
(8,54);

insert transactions_05 values
(2,5,310),
(3,5,200),
(9,5,100),
(12,1,123),
(13,2,232);

with p1 as (
select visit_id, customer_id from visits_05 where visit_id not in(
select visit_id from transactions_05 group by visit_id)
)
select customer_id, count(visit_id) as count_no_trans from p1 group by customer_id order by count_no_trans desc;

create table orders_06(
id int,
order_date date,
customer_id int,
product_id int);

insert orders_06 values
(1,'2020-07-31',1,1),
(2,'2020-07-30',2,2),
(3,'2020-08-29',3,3),
(4,'2020-07-29',4,1),
(5,'2020-06-10',1,2),
(6,'2020-08-01',2,1),
(7,'2020-08-01',3,3),
(8,'2020-08-03',1,2),
(9,'2020-08-07',2,3),
(10,'2020-07-15',1,2);

with p1 as(
select customer_id,product_id,ct, rank() over(partition by customer_id order by ct desc) as rk from (
select customer_id,product_id,count(order_date) as ct 
from orders_06 group by customer_id,product_id order by customer_id) d 
) 
select customer_id, product_id from p1 where rk=1 group by customer_id,product_id order by customer_id
;

create table schoolc(
id int,
name varchar(20)
);

insert schoola values
(1,'alice'),
(2,'bob');

insert schoolc values
(3,'tom'),
(2,'jerry'),
(10,'alice');

select a.name as member_A, b.name as member_B, c.name as member_C from schoola a, schoolb b, schoolc c 
where a.name!=b.name and b.name!=c.name and a.name!=c.name and a.id!=b.id and b.id!=c.id and a.id!=c.id
group by member_A,member_B,member_c;


create table drivers(
driver_id int,
join_date date);

create table rides(
ride_id int,
user_id int,
requested_at date);

create table acceptedrides(
ride_id int,
driver_id int);

insert drivers values
(10,'2019-12-10'),
(8,'2020-01-13'),
(5,'2020-02-16'),
(7,'2020-03-08'),
(4,'2020-05-17'),
(1,'2020-10-24'),
(6,'2021-01-05');

insert rides values
(6,75,'2019-12-09'),
(1,54,'2020-02-09'),
(10,63,'2020-03-04'),
(19,39,'2020-04-06'),
(3,41,'2020-06-03'),
(13,52,'2020-06-22'),
(7,69,'2020-07-16'),
(17,70,'2020-08-25'),
(20,81,'2020-11-09'),
(5,57,'2020-11-09'),
(2,42,'2020-12-09'),
(11,68,'2021-01-11');

insert acceptedrides values
(10,10),
(13,10),
(7,8),
(17,7),
(20,1),
(5,7),
(2,4),
(11,8),
(15,8),
(12,8),
(14,1);


with p1 as(
select 1 as month, count(driver_id) as active_drivers from drivers where join_date<='2020-01-31' 
union
select 2 as month, count(driver_id) as active_drivers from drivers where join_date<='2020-02-28'
union 
select 3 as month, count(driver_id) as active_drivers from drivers where join_date<='2020-03-31'
union 
select 4 as month, count(driver_id) as active_drivers from drivers where join_date<='2020-04-30'
union
select 5 as month, count(driver_id) as active_drivers from drivers where join_date<='2020-05-31'
union
select 6 as month, count(driver_id) as active_drivers from drivers where join_date<='2020-06-30'
union 
select 7 as month, count(driver_id) as active_drivers from drivers where join_date<='2020-07-31'
union
select 8 as month, count(driver_id) as active_drivers from drivers where join_date<='2020-08-31'
union 
select 9 as month, count(driver_id) as active_drivers from drivers where join_date<='2020-09-30'
union 
select 10 as month, count(driver_id) as active_drivers from drivers where join_date<='2020-10-31' 
union 
select 11 as month, count(driver_id) as active_drivers from drivers where join_date<='2020-11-30'
union
select 12 as month, count(driver_id) as active_drivers from drivers where join_date<='2020-12-31'
),
p2 as (
select 1 as month, count(ride_id) as accepted_rides from 
(select a.ride_id, requested_at from acceptedrides a left join rides b on a.ride_id=b.ride_id 
group by a.ride_id) a
where 
month(requested_at)= 1 and year(requested_at)=2020
union
select 2 as month, count(ride_id) as accepted_rides from 
(select a.ride_id, requested_at from acceptedrides a left join rides b on a.ride_id=b.ride_id 
group by a.ride_id) a
where 
month(requested_at)= 2 and year(requested_at)=2020
union
select 3 as month, count(ride_id) as accepted_rides from 
(select a.ride_id, requested_at from acceptedrides a left join rides b on a.ride_id=b.ride_id 
group by a.ride_id) a
where 
month(requested_at)= 3 and year(requested_at)=2020
union
select 4 as month, count(ride_id) as accepted_rides from 
(select a.ride_id, requested_at from acceptedrides a left join rides b on a.ride_id=b.ride_id 
group by a.ride_id) a
where 
month(requested_at)= 4 and year(requested_at)=2020
union
select 5 as month, count(ride_id) as accepted_rides from 
(select a.ride_id, requested_at from acceptedrides a left join rides b on a.ride_id=b.ride_id 
group by a.ride_id) a
where 
month(requested_at)= 5 and year(requested_at)=2020
union
select 6 as month, count(ride_id) as accepted_rides from 
(select a.ride_id, requested_at from acceptedrides a left join rides b on a.ride_id=b.ride_id 
group by a.ride_id) a
where 
month(requested_at)= 6 and year(requested_at)=2020
union
select 7 as month, count(ride_id) as accepted_rides from 
(select a.ride_id, requested_at from acceptedrides a left join rides b on a.ride_id=b.ride_id 
group by a.ride_id) a
where 
month(requested_at)= 7 and year(requested_at)=2020
union
select 8 as month, count(ride_id) as accepted_rides from 
(select a.ride_id, requested_at from acceptedrides a left join rides b on a.ride_id=b.ride_id 
group by a.ride_id) a
where 
month(requested_at)= 8 and year(requested_at)=2020
union
select 9 as month, count(ride_id) as accepted_rides from 
(select a.ride_id, requested_at from acceptedrides a left join rides b on a.ride_id=b.ride_id 
group by a.ride_id) a
where 
month(requested_at)= 9 and year(requested_at)=2020
union
select 10 as month, count(ride_id) as accepted_rides from 
(select a.ride_id, requested_at from acceptedrides a left join rides b on a.ride_id=b.ride_id 
group by a.ride_id) a
where 
month(requested_at)= 10 and year(requested_at)=2020
union
select 11 as month, count(ride_id) as accepted_rides from 
(select a.ride_id, requested_at from acceptedrides a left join rides b on a.ride_id=b.ride_id 
group by a.ride_id) a
where 
month(requested_at)= 11 and year(requested_at)=2020
union
select 12 as month, count(ride_id) as accepted_rides from 
(select a.ride_id, requested_at from acceptedrides a left join rides b on a.ride_id=b.ride_id 
group by a.ride_id) a
where 
month(requested_at)= 12 and year(requested_at)=2020
)

select p1.month,p1.active_drivers,p2.accepted_rides, round(accepted_rides/active_drivers*100,2) as working_percentage
from p1 left join p2 on p1.month=p2.month;

create table activity(
machine_id int,
process_id int,
type varchar(20),
timestamp float);

insert activity values
(0,0,'s',0.712),
(0,0,'e',1.520),
(0,1,'s',3.140),
(0,1,'e',4.120),
(1,0,'s',0.550),
(1,0,'e',1.550),
(1,1,'s',0.430),
(1,1,'e',1.420),
(2,0,'s',4.100),
(2,0,'e',4.512),
(2,1,'s',2.500),
(2,1,'e',5.000);

with p1  as (
select machine_id, process_id, sum(if(type='s',-timestamp,timestamp)) as time from activity 
group by machine_id,process_id
)
select machine_id, round(avg(time),3) from p1 group by  machine_id;

create table calls_1(
form_id int,
to_id int,
duration int
);

insert calls_1 values
(1,2,59),
(2,1,11),
(1,3,20),
(3,4,100),
(3,4,200),
(3,4,200),
(4,3,499);

select p.form_id, p.to_id, p.duration+q.duration from calls_1 p left join calls_1 q 
on p.form_id=q.to_id and p.to_id=q.form_id group by form_id,to_id;

with p1 as (
select p.form_id, p.to_id, sum(p.duration) as duration,count(*) as count
from calls_1 p group by form_id,to_id
union
select p.to_id as form_id, p.form_id as to_id, sum(p.duration) as duration, count(*) as count
 from calls_1 p group by form_id,to_id
 )
 
select form_id, to_id,sum(count) as count, sum(duration) as duration from p1 where form_id<to_id
group by form_id,to_id;

create  table uservisits(
id int,
visit_date date
);

insert uservisits values
(1,'2020-11-28'),
(1,'2020-10-20'),
(1,'2020-12-03'),
(2,'2020-10-05'),
(2,'2020-12-09'),
(3,'2020-11-11');


select id, max(window_no) as biggest_window from (
with p1 as (
select id,visit_date, 
(case when lead(visit_date) over(partition by id order by visit_date) is null then '2021-01-01' else
 lead(visit_date) over(partition by id order by visit_date) end) as date_no
from uservisits
)
select id,visit_date, datediff(date_no,visit_date) as window_no from p1 group by id,visit_date
) t group by id;


create table boxes(
box_id int,
chest_id int,
apple_count int,
orange_count int);

create table chests(
chest_id int,
apple_count int,
orange_count int);

insert boxes values
(2,null,6,15),
(18,14,4,15),
(19,3,8,4),
(12,2,19,20),
(20,6,12,9),
(8,6,9,9),
(3,14,16,7);

insert chests values
(6,5,6),
(14,20,10),
(2,8,8),
(3,19,4),
(16,19,19);

with p1 as (
select box_id, p.chest_id, p.apple_count,p.orange_count,q.apple_count as apple, q.orange_count as orange
from boxes p left join chests q on p.chest_id=q.chest_id group by box_id
) 
select sum(p1.apple_count)+sum(apple) as apple_count, sum(orange_count)+sum(orange) as orange_count from 
p1;

create table employee_001(
id int,
name varchar(20),
reports_to int,
age int);

insert employee_001 values
(9,'henry',null,43),
(6,'alice',9,41),
(4,'bob',9,36),
(2,'winston',null,37);

select reports_to as id, count(id) as reports_count, round(avg(age),0) 
from employee_001 where reports_to is not null group by reports_to;

create table employees_002(
id int,
event_day date,
in_time int,
out_time int);

insert employees_002 values
(1,'2020-11-28',4,32),
(1,'2020-11-28',55,200),
(1,'2020-12-03',1,42),
(2,'2020-11-28',3,33),
(2,'2020-12-09',47,74);

with p1  as (
select id, event_day, out_time-in_time as total from employees_002
)
select id, event_day, sum(total) from p1 group by id, event_day;

