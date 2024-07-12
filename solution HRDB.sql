use hrdb;
-- Q1.1
select * from employees;

-- Q1.2
select * from departments;

-- Q 1.3
select concat(FIRST_NAME," ,",JOB_ID) AS "EMPLOYEE AND TITLE" from employees;

-- Q1.4
select HIRE_DATE, FIRST_NAME, department_ID FROM EMPLOYEES
WHERE JOB_ID = "PU_CLERK";

-- Q1.5
select concat_ws(", ",EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID ) AS "THE OUTPUT" from EMPLOYEES;

-- Q1.6
select FIRST_NAME, SALARY FROM EMPLOYEES
where SALARY >2000;

-- Q1.7
select FIRST_NAME AS "NAME", HIRE_DATE AS "START DATE" FROM EMPLOYEES;

-- Q1.8
select FIRST_NAME AS "NAME", HIRE_DATE AS "START DATE" FROM EMPLOYEES
order by HIRE_DATE;

-- Q1.9
select FIRST_NAME, SALARY FROM employees 
order by SALARY desc;

-- 1.10
select FIRST_NAME, DEPARTMENT_ID, SALARY FROM employees
where commission_pct IS NOT NULL
order by SALARY desc;

-- Q1.11
select LAST_NAME, JOB_ID FROM employees
where MANAGER_ID IS NULL; 

-- Q1.12
select LAST_NAME, JOB_ID, SALARY FROM employees
WHERE (JOB_ID = "SA_REP" || JOB_ID = "ST_CLERK") && (SALARY != 2500 && SALARY != 3500 && SALARY != 5000);

-- Q2.1
select min(SALARY), max(SALARY), avg(SALARY) FROM employees
where commission_pct IS not null;

-- Q2.2
select department_ID, SUM(SALARY) AS "TOTAL SALARY", SUM(COMMISSION_PCT*SALARY)  AS "COMMISSION PAYOUT" FROM
employees group by department_id;

-- Q2.3
select department_ID, COUNT(EMPLOYEE_ID) AS "NUMBER OF EMPLOYEES" FROM employees
group by department_id;

-- Q2.4
select department_ID, SUM(SALARY) AS "TOTAL SALRY" FROM employees
group by department_id;

-- Q2.5
select FIRST_NAME  FROM employees
where commission_pct IS NULL
order by 1;

-- Q2.6
select FIRST_NAME "NAME", department_ID "DEPARTMENT", ifnull(COMMISSION_PCT, "NO COMMISION") "COMMISSION" FROM employees;

-- Q2.7
select FIRST_NAME "NAME", SALARY , ifnull(COMMISSION_PCT*2, "NO COMMISION") "COMMISSION" FROM employees;

-- Q2.8
SELECT DISTINCT e1.first_name, e1.department_id
FROM employees e1
JOIN employees e2 ON e1.first_name = e2.first_name
                 AND e1.employee_id <> e2.employee_id
                 AND e1.department_id = e2.department_id
ORDER BY e1.department_id, e1.first_name;

-- Q2.9
select MANAGER_ID,sum(SALARY) "TOTAL SALARY" FROM employees
group by manager_id;

-- Q2.10
SELECT 
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    COUNT(e.employee_id) AS employee_count,
    m.department_id AS manager_department_id
FROM employees m -- m represents managers
JOIN employees e ON m.employee_id = e.manager_id -- e represents employees under managers
GROUP BY m.employee_id, m.first_name, m.last_name, m.department_id
ORDER BY manager_name;
 
-- Q2.11
select concat(m.first_name, ' ', m.last_name) as Manager_name,
e.first_name as "employee first name", e.department_id, e.salary
from employees e
join employees m on m.employee_id = e.manager_id
where substring(e.last_name, 2, 1) = 'a'
order by Manager_name;

-- Q2.12
select department_id, avg(salary) from employees
group by department_id
order by department_id;

-- Q2.13
select department_id, max(salary) from employees
group by department_id
order by department_id;

-- Q2.14
-- using case statement
select 
    commission_pct,
    case
        when commission_pct is null then 1
        else 0.1 * salary
    end as calculated_commission
from employees;

-- using if function
select 
    commission_pct,
    if(commission_pct is null, 1, 0.1 * salary) as calculated_commission
from employees;

-- Q3.1
select concat(upper(substring(last_name,2,1)),lower(substring(last_name,3,3))) as "modified lasr name" from employees;

-- Q3.2
select first_name, last_name, month(hire_date), concat(first_name, "-", last_name)
from employees;

-- Q3.3
-- with if function
select last_name as 'Employee Last Name',
	if(salary*0.5 > 10000, 
    salary+salary*0.1 + 1500, 
    salary+salary*0.115 + 1500) as 'Adjusted Salary with Bonus'
    from employees;
    
-- with case staement
SELECT 
    last_name AS "Employee Last Name",
    CASE
        WHEN salary * 0.5 > 10000 THEN ROUND(salary * 1.1 + 1500, 2)
        ELSE ROUND(salary * 1.115 + 1500, 2)
    END AS "Adjusted Salary with Bonus"
FROM employees;

-- Q3.4
select ID, A, B, replace(Manager_name, 'Z', '$') as mname
from (select concat(substring(e1.employee_id, 1, 2), '00', substring(e1.employee_id, 3,1), 'E') as 'ID',
	e1.department_id as 'A',
	e1.salary as 'B',
	upper(concat(e2.first_name, ' ', e2.last_name)) as Manager_name
	from employees e2 join employees e1
	on e1.employee_id = e2.manager_id) as sub;
    
    
    -- Q3.5
select concat(upper(substring(last_name,1,1)),lower(substring(last_name,2))) as lname, length(last_name) as "name lenght"
from employees
where last_name like "J%" or last_name like "A%" or last_name like "M%"
order by last_name;

-- Q3.6
select last_name as "LAST NAME", lpad(salary, 15, "$") AS "SALARY" FROM employees;

-- Q3.7
select first_name from employees
where first_name = reverse(first_name);

-- Q3.8
select concat(upper(substring(first_name,1,1)),lower(substring(first_name,2))) as "FIRST NAME"
from employees; 

-- Q3.9
select*from LOCATIONS;

SELECT 
    SUBSTRING(SUBSTRING_INDEX(STREET_ADDRESS, ' ', 3), 
        LOCATE(' ', STREET_ADDRESS) + 1, 
        LOCATE(' ', SUBSTRING_INDEX(STREET_ADDRESS, ' ', 3), LOCATE(' ', STREET_ADDRESS)+1) - LOCATE(' ', STREET_ADDRESS) 
    ) AS Middle_Word
FROM 
    LOCATIONS;
    
select substring(street_address,
        locate(" ", street_address)+1,
        locate(" ",street_address,locate(" ", street_address)+1)-locate(" ", street_address)) as street
        from locations;
        
-- Q3.10
select lower(concat(substring(first_name,1,1),replace(last_name," ",""),"@systechusa.com")) as "e-mail address",
 first_name from employees;
        

-- Q3.11
select*from jobs;
select*from employees;
select concat(employees.first_name," ",employees.last_name) as name, jobs.job_title from employees join jobs
on employees.job_id = jobs.job_id
where employees.job_id = (select job_id from employees where	first_name = "trenna"); 


-- Q3.12
select concat(first_name," ",last_name) as name, department_name from emp_details_view
where city = (select city from emp_details_view where first_name = "trenna"); 
select*from emp_details_view;

-- Without using emp detailed view
select e.first_name, d.department_name from employees e
join departments d on e.department_id = d.department_id
join locations l ON d.location_id = l.location_id
where l.city = (select l2.city 
              from employees e2
              join departments d2 on e2.department_id = d2.department_id
              join locations l2 on d2.location_id = l2.location_id
              where e2.first_name = 'Trenna');

select * from emp_details_view;

-- With using emp detailed view
select first_name, department_name from emp_details_view
where city = (select city 
            from emp_details_view 
            where first_name = 'Trenna');
-- Q3.13
select first_name, last_name from employees
where salary = (select min(salary) from employees);


-- Q3.14
select first_name, last_name from employees
where salary > (select min(salary) from employees);




-- Q4.1
select e.last_name, d.department_id, d.department_name from employees e join departments d
on e.department_id = d.department_id ;

-- Q4.2
select j.job_title, l.city from jobs j
join employees e on e.job_id = j.job_id
join departments d on d.department_id = e.department_id
join locations l on l.location_id = d.location_id
where e.department_id = 40;

-- Q4.3
select e.last_name, d.department_name, l.location_id, l.city from employees e 
join departments d on d.department_id = e.department_id
join locations l on l.location_id = d.location_id
where e.commission_pct is not null;

-- Q4.4
select e.last_name, d.department_name from employees e 
join departments d on d.department_id = e.department_id
where e.last_name like "%a%";

-- Q4.5
select e.last_name, j.job_title, d.department_id, d.department_name from employees e
join departments d on d.department_id = e.department_id
join jobs j on j.job_id = e.job_id
join locations l on l.location_id = d.location_id
where l.city = 'ATLANTA';

-- Q4.6
select e.employee_id 'Employee id', e.last_name 'Employee name', e.manager_id 'Manager id', m.last_name 'Manager name' from employees e
join employees m on e.manager_id = m.employee_id;

-- Q4.7
select e.employee_id 'Employee id', e.last_name 'Employee name', e.manager_id 'Manager id', m.last_name 'Manager name' from employees e
left join employees m on e.manager_id = m.employee_id;

-- Q4.8
select e1.last_name AS employee_last_name, e1.department_id AS department_number, e2.last_name AS colleague_last_name from employees e1
join employees e2 on e1.department_id = e2.department_id and e1.employee_id != e2.employee_id
order by e1.department_id, e1.last_name, e2.last_name;

-- Q4.9
-- with case statement
select e.first_name, j.job_title, d.department_name, e.salary,
case
	when salary >= 5000 then 'A'
    when salary >= 3000 then 'B'
    else 'C'
end as 'Grade'
from employees e
join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id;

-- with if conditions
select e.first_name, j.job_title, d.department_name, e.salary,
if(salary >= 5000, 'A', if(salary >= 3000, 'B', 'C')) as 'Grade'
from employees e
join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id;

-- Q4.10
select e.hire_date 'Employee Hire Date', e.last_name 'Employee name', m.hire_date 'Manager Hire Date', m.last_name 'Manager name' from employees e
join employees m on e.manager_id = m.employee_id
where e.hire_date < m.hire_date;



-- Q5.1
select e.last_name, e.hire_date from employees e
join departments d on e.department_id = d.department_id
where d.department_name = 'Sales';

-- Question 5-2)
select employee_id, last_name from employees
where salary > (select avg(salary) from employees) 
order by salary asc;

-- Question 5-3)
-- With sub query
select last_name, emplyoee_id from employees
where department_id in
(select id from (select last_name, department_id as id from employees
where last_name like "%u%") as sub);

-- with self join
SELECT 
    e1.employee_id AS employee_number, 
    e1.last_name AS employee_last_name
FROM 
    employees e1
WHERE 
    e1.department_id IN (
        SELECT 
            e2.department_id
        FROM 
            employees e2
        WHERE 
            e2.last_name LIKE '%u%'
    )
ORDER BY 
    e1.department_id, e1.employee_id;
    
-- Question 5-4)
select e.last_name, j.job_id, d.department_id from employees e
join departments d on d.department_id = e.department_id
join jobs j on j.job_id = e.job_id
join locations l on l.location_id = d.location_id
where l.city = 'ATLANTA';

-- Question 5-5)
-- with Sub Query
select last_name, salary from employees
where manager_id = (select employee_id from employees where last_name = 'Fillmore');

-- With Self join
SELECT 
    e.last_name AS employee_last_name,
    e.salary AS employee_salary
FROM 
    employees e
JOIN 
    employees m 
ON 
    e.manager_id = m.employee_id
WHERE 
    m.last_name = 'FILLMORE';
    
-- Question 5-6)
select e.department_id, e.last_name, e.job_id from employees e
join departments d on d.department_id = e.department_id
where d.department_name = 'Operations';

-- Question 5-7)
select employee_id, last_name, salary from employees
where salary > (select avg(salary) from employees) and
department_id in (select id from (select department_id as id from employees
where last_name like "%u%") as sub);

-- Question 5-8)
-- with in function
select first_name from employees
where job_id in (select job_id from employees e
					join departments d on e.department_id = d.department_id
                    where d.department_name = 'Sales');

-- With joining
select e.first_name from employees e
join departments d on d.department_id = e.department_id
where department_name = 'Sales';

-- Question 5-9)
select employee_id, salary,
case
	when department_id = 10 or department_id = 30 then '5%'
    when department_id = 40 or department_id = 50 then '15%'
    when department_id = 20  then '10%' 
    when department_id = 60 then 'No raise'
    else '-'
end as 'Raise Percentage',
salary * (1 + case
				when department_id in (10, 30) then 0.05
                when department_id = 20 then 0.10
                when department_id in (40, 50) then 0.15
                when department_id = 60 then 0.00
                else 0.00
end) as new_salary
from employees;

-- Question 5-10)
select last_name, salary from employees
order by salary desc limit 3;

-- Question 5-11)
select first_name, salary, ifnull(commission_pct, 0) as 'Commission'  from employees;

-- Question 5-12)
select concat(m.first_name, ' ', m.last_name) as Manager_name, m.salary, d.department_name from employees m
join employees e on m.employee_id = e.manager_id
join departments d on d.department_id = m.department_id
group by manager_name, salary, d.department_name
order by salary desc limit 3;






 


    

 




