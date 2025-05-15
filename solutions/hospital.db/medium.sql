--Show unique birth years from patients and order them by ascending.
select DISTINCT YEAR(birth_date) as birth_year
from patients
order by birth_year;

--Show unique first names from the patients table which only occurs once in the list.
--For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
select first_name
from patients
group by first_name
HAVING COUNT(first_name) = 1;

--Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select patient_id, first_name
from patients
where
SUBSTR(first_name, -1, 1) = 's' AND SUBSTR(first_name, 1, 1) = 'S'
AND LENGTH(first_name) >=6;

--Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
--Primary diagnosis is stored in the admissions table.
select patient_id, first_name, last_name
from patients
JOIN admissions using (patient_id)
where diagnosis = 'Dementia';

--Display every patient's first_name.
--Order the list by the length of each name and then by alphabetically.
select first_name
from patients
order by LENGTH(first_name), first_name;

--Show the total amount of male patients and the total amount of female patients in the patients table.
--Display the two results in the same row.
select
(select COUNT(*) from patients where gender = 'M'),
(select COUNT(*) from patients where gender = 'F')
;

--Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
select first_name, last_name, allergies
from patients
where allergies = 'Penicillin' OR allergies = 'Morphine'
order by allergies, first_name, last_name;

--Show all allergies ordered by popularity. Remove NULL values from query.
select allergies as alg, count(patient_id)
from patients
where allergies is not NULL
group by allergies
order by count(patient_id) DESC;

--Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name, last_name, birth_date
from patients
where YEAR(birth_date) between 1970 AND 1979
order by birth_date;

--We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
--EX: SMITH,jane
select UPPER(last_name) || ',' || lower(first_name) 
from patients
order by first_name desc;

--Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select province_id, sum(height)
from patients
group by province_id
having sum(height) >= 7000;

--Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select max(weight) - min(weight)
from patients
where last_name = 'Maroni';

--Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select day(admission_date) dt, count(admission_date) as ct
from admissions
group by dt
order by ct DESC;

--Show all columns for patient_id 542's most recent admission_date.
select *
from admissions
where patient_id = 542
and admission_date = (select max(admission_date) from admissions
                     where patient_id = 542);
                     
--Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
--1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
--2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
select patient_id, attending_doctor_id, diagnosis
from admissions
where (patient_id%2<>0 and attending_doctor_id IN (1,5,19))
or (attending_doctor_id LIKE '%2%' and length(patient_id) = 3);

--Show first_name, last_name, and the total number of admissions attended for each doctor.
--Every admission has been attended by a doctor.
select first_name, last_name, count(admission_date)
from admissions, doctors
where doctor_id = attending_doctor_id
group by doctor_id;

--For each doctor, display their id, full name, and the first and last admission date they attended.
select doctor_id, first_name || ' ' || last_name,
min(admission_date), max(admission_date)
from admissions, doctors
where doctor_id = attending_doctor_id
group by doctor_id;

--Display the total amount of patients for each province. Order by descending.
select province_name, count(province_id) as ct
from province_names
join patients using (province_id)
group by province_name
order by ct DESC;

--For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
select p.first_name || ' ' || p.last_name, diagnosis,
d.first_name || ' ' || d.last_name
from patients p, doctors d
join admissions a on p.patient_id = a.patient_id and
a.attending_doctor_id = d.doctor_id;

--display the first name, last name and number of duplicate patients based on their first name and last name.
--Ex: A patient with an identical name can be considered a duplicate.
select p.first_name, p.last_name, 
(select count(*) from patients p2 where p2.first_name=p.first_name and
p2.last_name = p.last_name) as ct
from patients p
group by p.first_name, p.last_name, ct
having ct >1
order by ct desc, p.first_name, p.last_name;

--Display patient's full name,
--height in the units feet rounded to 1 decimal,
--weight in the unit pounds rounded to 0 decimals,
--birth_date,
--gender non abbreviated.
--Convert CM to feet by dividing by 30.48.
--Convert KG to pounds by multiplying by 2.205.
select concat(first_name, ' ',last_name) as patient_name,
Round(height/30.48, 1) as 'height "Feet"',
round(weight*2.205,0) as 'weight "Pounds"',
birth_date, case
	when gender = 'M' then 'MALE'
    else 'FEMALE'
    end as gender_type
from patients;

--Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)
select patient_id, first_name, last_name
from patients
where patient_id NOT IN (select patient_id from admissions);

--Display a single row with max_visits, min_visits, average_visits where the maximum, minimum and average number of admissions per day is calculated. Average is rounded to 2 decimal places.
select MAX(max_visits), MIN(max_visits), round(AVG(max_visits), 2)
from(select count(admission_date) as "max_visits"
from admissions
group by admission_date);