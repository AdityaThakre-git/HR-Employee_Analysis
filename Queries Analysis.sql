
-- GENDER BEAKDOWN OF EMPLOYEES
SELECT gender, COUNT(*) AS count
FROM hr
WHERE age >=18 and termdate = '0000-00-00'
GROUP BY gender;

-- race distribution across company
SELECT race, COUNT(*) AS count
FROM hr
WHERE age >=18 and  termdate = '0000-00-00'
GROUP BY race
ORDER BY count DESC;

-- Age distribution
SELECT 
  MIN(age) AS youngest,
  MAX(age) AS oldest
FROM hr
where age >= 18;

SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+' 
  END AS age_group, gender,
  COUNT(*) AS count
FROM 
  hr
WHERE 
  age >= 18
GROUP BY age_group, gender
ORDER BY age_group, gender;


-- Employees work at HQ vs Remote Location
SELECT location, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location;

-- AVG length of employement of employees who had terminated 
SELECT ROUND(AVG(DATEDIFF(termdate, hire_date))/365,0) AS avg_length_of_employment
FROM hr
WHERE termdate <> '0000-00-00' AND termdate <= CURDATE() AND age >= 18;


-- Gender distribution across departments
SELECT department, gender, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY department, gender
ORDER BY department;

-- Distribution of job title across the company
SELECT jobtitle, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- Department wise turnover rate
SELECT department,total_count,terminated_count, terminated_count/total_count as termination_rate
from(
	select department,
    count(*) as total_count,
    sum(case when termdate != '0000-00-00' and termdate <= curdate() then 1 else 0 end) as terminated_count
    from hr
    where age>=18
    group by department
    )as subquery
ORDER BY termination_rate DESC;

-- Distribution of employees across location by state
SELECT location_state, COUNT(*) as count
FROM hr
WHERE age >= 18 and termdate = '0000-00-00'
GROUP BY location_state
ORDER BY count DESC;

-- Change in Company's employee count
SELECT year, hires, terminations, (hires - terminations) AS net_change, ROUND(((hires - terminations) / hires * 100), 2) AS net_change_percent
FROM (
    SELECT YEAR(hire_date) AS year, COUNT(*) AS hires, 
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
    FROM hr
    WHERE age >= 18
    GROUP BY YEAR(hire_date)
) subquery
ORDER BY year ASC;
    
-- Tenure Distribution in each department
SELECT department, ROUND(AVG(DATEDIFF(CURDATE(), termdate)/365),0) as avg_tenure
FROM hr
WHERE termdate <= CURDATE() AND termdate <> '0000-00-00' AND age >= 18
GROUP BY department
    
    
