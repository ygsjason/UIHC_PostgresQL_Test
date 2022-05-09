--UIHC_SQL_Test_Date:05082022

Q1
with temp_cte as 
(select id, lastName, role, department from employee),
temp_emp as (select id, lastName, role, department, supervisorId from employee)
 select * from temp_emp
left join temp_cte on temp_emp.supervisorId = temp_cte.id
order by temp_cte.lastName, temp_cte.department

Q2
with temp_v as (select * from visit where class = 'Inpatient'),
temp_p as (select id, lastName from patient),
temp_e as (select id, lastName from employee)
select * from temp_v
left join temp_p on temp_v.patientid = temp_p.id
left join temp_e on temp_v.providerid = temp_e.id

Q3
with temp_e as (select id, lastName from employee)
select * from visit
left join temp_e on visit.providerid = temp_e.id
where class = 'Rehab'
and patientid in (select patientid from visit where class = 'Inpatient')

Q4
select patientid, class, startdate as visit_date, 
lag(startdate,1) over (partition by patientid order by startdate) as prev_visit_date
from visit
where class != 'Rehab'

Q5
with rank as (select lastname, role, EXTRACT(YEAR FROM hireDate) as year from employee)
select lastname, role, 
dense_rank() over(order by year desc) as ranking
from rank
