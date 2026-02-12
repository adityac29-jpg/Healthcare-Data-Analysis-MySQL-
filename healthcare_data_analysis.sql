create database helthcare;
use helthcare ;

create table healthcare_data(
Name varchar(50),
Age int,
Gender varchar(15),
Blood_Type varchar(10),
Medical_Condition varchar(20),
Date_of_Admission date,
Doctor varchar(60),
Hospital varchar(100),
Insurance_Provider varchar(20),
Billing_Amount int,
Room_Number int,
Admission_Type varchar(50),
Discharge_Date date,
Medication varchar(50),
Test_Results varchar(50) ) ;

select * from healthcare_data ;  -- view the data

-- data cleaning 

-- 1. update the name collumn to proper case
set sql_safe_updates = 0 ;

update healthcare_data 
set name = concat(UPPER(LEFT(name, 1)), Upper(SUBSTRING(name, 2)));

-- 2. removeduplicate data
create table uni_data as select * from healthcare_data
union select * from healthcare_data ;

-- 3. Which hospital has had the most number of visit
select Hospital, count(Hospital) as 'number' from uni_data group by 1 order by 2 desc ;

-- 4. Which patients have visited a hospital most
select Name, count(Name) as hospital_visit from uni_data group by 1 order by 2 desc ;

-- 5. Which medical condition does this hospital treat
select distinct Medical_Condition from uni_data ;

-- 6. number of doctor
select count(distinct Doctor) as number from uni_data ;

-- 7. what is the highest medicl bill that a patient has 
select Name, Billing_Amount from uni_data  order by 2 desc ;

-- 8. what is the smallest medical bill that a patient has
select Name, Billing_Amount from uni_data where 
Billing_Amount > 1 order by 2 asc ;

-- 9. which doctor have had the most of pation visit
select Doctor, count(Doctor) as number_of_visit from uni_data 
group by 1 order by 2 desc ;

-- 10. how many times are each medical condition treated 
select Medical_Condition, count(Medical_Condition) as 
Number_of_instances from uni_data group by 1 order by 2 desc ;

-- 11. which patients have been admitted for multiple conditions 
select Name, count(distinct Medical_Condition) as multiple_conditions
from uni_data group by 1 having count(distinct Medical_Condition) > 1
order by 2 desc ;

-- 12. what is the corelation between age and billing amount 
select case when age < 15 then 'Below 15'
			when age between 15 and 24 then '15-24'
            when age between 25 and 34 then '25-34'
            when age between 35 and 44 then  '35-44'
			when age between 45 and 54 then '45-54'
            when age between 55 and 65 then  '55-64'
            else 'above 65' end as age_group ,
round(avg(Billing_Amount),2) as  avg_bill from uni_data 
group by 1 order by 1 ;

-- 13. calculate the correlation coefficient between age and billing_amount
SELECT
(  COUNT(*) * SUM(Age * Billing_Amount) - SUM(Age) * SUM(Billing_Amount)  ) 
/
SQRT(   
		(COUNT(*) * SUM(Age * Age) - POW(SUM(Age), 2)) *
        (COUNT(*) * SUM(Billing_Amount * Billing_Amount) - POW(SUM(Billing_Amount), 2))  ) AS correlation_coefficient
FROM uni_data;














































































































