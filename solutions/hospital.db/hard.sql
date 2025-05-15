--Show all of the patients grouped into weight groups.
--Show the total amount of patients in each weight group.
--Order the list by the weight group decending.
--For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
select (SELECT count(*) from patients
        where weight between (p.weight/10)*10
        and ((p.weight/10)*10)+9) as patients_in_group,
(weight/10)*10 as weight_group
from patients p
group by weight_group
order by weight_group DESC;

--Show patient_id, weight, height, isObese from the patients table.
--Display isObese as a boolean 0 or 1.
--Obese is defined as weight(kg)/(height(m)2) >= 30.
--weight is in units kg.
--height is in units cm.
select patient_id, weight, height,
	CASE
    WHEN (weight/ ( (height/100.0) * (height/100.0) ) ) >= 30
    then 1
    else 0
   	end as isObese
from patients;

--Show patient_id, first_name, last_name, and attending doctor's specialty.
--Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
--Check patients, admissions, and doctors tables for required information.
select p.patient_id, p.first_name, p.last_name, d.specialty
from patients p
JOIN doctors d on doctor_id = attending_doctor_id
join admissions using (patient_id)
where diagnosis = 'Epilepsy' and d.first_name = 'Lisa';

--All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
--The password must be the following, in order:
--1. patient_id
--2. the numerical length of patient's last_name
--3. year of patient's birth_date
select patient_id, 
(select concat(patient_id, length(last_name), YEAR(birth_date)))
from patients
where patient_id IN (select patient_id from admissions);

--Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
--Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.
select CASE
WHEN patient_id%2 = 1 then 'No'
else 'Yes'
end as has_insurance, CASE
WHEN patient_id%2 = 1 then (select count(*) from admissions where patient_id%2=1) *50
else (select count(*) from admissions where patient_id%2=0) *10
end as cost_after_insurnace
from admissions
group by has_insurance;

--Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
select province_name
from province_names pn
join patients p using(province_id)
where (select count(*) from patients where province_id = pn.province_id and gender = 'M')
> (select count(*) from patients where province_id = pn.province_id and gender = 'F')
group by province_name;

--We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
-- First_name contains an 'r' after the first two letters.
-- Identifies their gender as 'F'
-- Born in February, May, or December
-- Their weight would be between 60kg and 80kg
-- Their patient_id is an odd number
-- They are from the city 'Kingston'
select *
from patients
where first_name LIKE '__r%'
and gender = 'F'
and month(birth_date) IN (02, 05, 12)
and weight between 60 and 80
and patient_id%2 = 1
and city = 'Kingston';

--Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.
select round(((select count(*) from patients where gender = 'M')/(count(*)*1.0))*100, 2)||'%'
from patients;

--For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
SELECT
 admission_date,
 count(admission_date) as admission_day,
 count(admission_date) -LAG(count(admission_date))
 OVER(ORDER BY admission_date) AS admission_count_change 
FROM admissions
 group by admission_date
 
 --Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
 select province_name
from province_names
order by
  (case when province_name = 'Ontario' then 0 else 1 end),
  province_name
  
--We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.
select doctor_id, first_name || ' ' || last_name as name, specialty,
year(admission_date) yr, count(year(admission_date))
from doctors
join admissions on (attending_doctor_id = doctor_id)
group by doctor_id, name, specialty, yr;
