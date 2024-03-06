create database healthcare_dialysis;
use healthcare_dialysis;

create table dialysis1 (
Provider_Number	int unsigned,
Facility_Name varchar(100),
City varchar(30),
State varchar(10),
Country varchar(10),
Profit_Non_Profit varchar(20),
Chain_Organization varchar(45),
Dialysis_Stations int,
patients_in_transfusion_summary int,
patients_in_hypercalcemia_summary int,
patients_in_Serum_phosphorus_summary int,
patients_in_hospitalization_summary int,
patients_in_hospital_readmission_summary int,
patients_in_survival_summary int,
patients_in_fistula_summary int,
patients_in_catheter_summary int,
patients_in_nPCR_summary int,
SWR_category_text varchar(30),
PPPW_category_text varchar(30),
Patient_hospitalization_category_text varchar(30),
Patient_Hospital_Readmission_Category_text varchar(30),
Patient_Survival_Category_Text varchar(30),
Patient_Infection_category_text varchar(30),
Fistula_Category_Text varchar(30),
Patient_Transfusion_category_text varchar(30),
primary key (Provider_Number));


create table dialysis2(
CCN	int unsigned,
Facility_Name varchar(100),	
Total_Performance_Score	int,
PY2020_Payment_Reduction_Percentage decimal(8,5),
primary key (CCN));

set sql_safe_updates=0;
set autocommit=0;

select * from dialysis2;

load data local infile 'D:/Users/SAURABH/Desktop/DA material/dialysis1'
into table dialysis1
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

set local_infile = 0;
 
 
 
 -- 1.Number of Patients across various summaries
 
 select 
	 sum(`patients_in_transfusion_summary`) 			as Transfusion_summary,
	 sum(`patients_in_hypercalcemia_summary`) 			as Hypercalcemia_summary,
	 sum(`patients_in_Serum_phosphorus_summary`) 		as Serum_Phosphorus_summary,
	 sum(`patients_in_hospitalization_summary`) 		as Hospitalization_summary,
	 sum(`patients_in_hospital_readmission_summary`) 	as Readmission_summary,
	 sum(`patients_in_survival_summary`) 				as Surival_summary,
	 sum(`patients_in_fistula_summary`) 				as Fistula_summary,
	 sum(`patients_in_catheter_summary`) 				as Catheter_summary,
	 sum(`patients_in_nPCR_summary`) 					as nPCR_summary
 from dialysis1;
 
 
 -- 2.Profit Vs Non-Profit Stats

select   `Profit_Non_Profit`, count(`Chain_Organization`) 
as 		 "#Chain Organization"
from     dialysis1
group by `Profit_Non_Profit`
limit    2;

-- 3.Chain Organizations w.r.t. Total Performance Score as No Score

select  		d1.`Chain_Organization`,d3.`TPS`
from            dialysis1 d1
join            dialysis2 d3
on              d1.`Provider_Number` = d3.`CCN`
where           d3.`TPS` = false;

-- 4.Dialysis Stations Stats
-- 4.a
select   `Chain_Organization`, sum(`Dialysis_Stations`) as total_DS 
from     dialysis1
group by `Chain_Organization`
order by total_DS desc;

-- 4.b
select sum(`Dialysis_Stations`) as total_DS 
from   dialysis1;


-- 5.# of Category Text  - As Expected

select 
	count(case when `SWR_category_text` = 'As Expected' then 1 end)  						 as SWR_category_text, 
	count(case when `PPPW_category_text` = 'As Expected' then 1 end) 						 as PPPW_category_text,
	count(case when `Patient_hospitalization_category_text` = 'As Expected' then 1 end) 	 as Patient_hospitalization_category_text,
	count(case when `Patient_Hospital_Readmission_Category_text` = 'As Expected' then 1 end) as Patient_Hospital_Readmission_Category_text,
	count(case when `Patient_Survival_Category_Text` = 'As Expected' then 1 end) 			 as Patient_Survival_Category_Text,
	count(case when `Patient_Infection_category_text` = 'As Expected' then 1 end) 			 as Patient_Infection_category_text,
	count(case when `Fistula_Category_Text` = 'As Expected' then 1 end) 					 as Fistula_Category_Text,
	count(case when `Patient_Transfusion_category_text` = 'As Expected' then 1 end) 		 as Patient_Transfusion_category_text
from dialysis1;

-- 6.Average Payment Reduction Rate

select avg(`PY2020_Payment_Reduction_Percentage`)
from   dialysis2;


select * from dialysis2;

select TPS from dialysis2
where TPS =




