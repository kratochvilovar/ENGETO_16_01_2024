
SELECT 
	pf.industry_branch,
	pf.`year`,
	pf2.`year` AS year_prev,
	round(avg(pf.avg_payroll )) AS average_payroll,
	round(avg(pf2.avg_payroll)) AS average_payroll_prev,
	round((avg(pf.avg_payroll ) - avg(pf2.avg_payroll)) / avg(pf2.avg_payroll) * 100,2) AS payroll_growth
FROM t_renata_kratochvilova_project_sql_primary_final pf
JOIN t_renata_kratochvilova_project_sql_primary_final pf2 
	ON pf.industry_branch = pf2.industry_branch 
	AND pf.year = pf2.`year` + 1
GROUP BY pf.industry_branch, pf.year
ORDER BY payroll_growth ASC
;


























