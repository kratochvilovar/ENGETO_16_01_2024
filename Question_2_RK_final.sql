-- CELKOVE POCTY V RAMCI VSECH ODVETVI

SELECT 
	`year`,
	name,
	price_value,
	price_unit,
	avg_price,
	round(avg(avg_payroll)) AS total_avg_payroll,
	round (avg(avg_payroll) / avg_price) AS guantity
FROM t_renata_kratochvilova_project_sql_primary_final trkpspf 
WHERE `year` IN ('2006','2018')
AND name IN ('Chléb konzumní kmínový','Mléko polotučné pasterované')
GROUP BY name, `year` 
;

-- DETAIL DLE JEDNOTLIVYCH ODVETVI

WITH quantity_2006 AS (
	SELECT 
		`year`,
		industry_branch,
		name,
		price_value,
		price_unit,
		avg_price,
		round(avg(avg_payroll)) AS total_avg_payroll,
		round(avg(avg_payroll) / avg_price) AS quantity_06
	FROM t_renata_kratochvilova_project_sql_primary_final trkpspf 
	WHERE `year` IN ('2006')
	AND name IN ('Chléb konzumní kmínový','Mléko polotučné pasterované')
	GROUP BY `year`, name, industry_branch 
	ORDER BY industry_branch, name, `year` 
),
quantity_2018 AS (
	SELECT 
		`year`,
		industry_branch,
		name,
		price_value,
		price_unit,
		avg_price,
		round(avg(avg_payroll)) AS total_avg_payroll,
		round(avg(avg_payroll) / avg_price) AS quantity_18
	FROM t_renata_kratochvilova_project_sql_primary_final trkpspf 
	WHERE `year` IN ('2018')
	AND name IN ('Chléb konzumní kmínový','Mléko polotučné pasterované')
	GROUP BY `year`, name, industry_branch 
	ORDER BY industry_branch, name, `year` 
)
SELECT 
	q.industry_branch,
	q.name,
	q.quantity_06,
	q2.quantity_18,
	q2.quantity_18 - q.quantity_06 AS Diff
FROM quantity_2006 q
JOIN quantity_2018 q2
ON q2.industry_branch = q.industry_branch
AND q2.name = q.name
ORDER BY Diff ASC 
;










