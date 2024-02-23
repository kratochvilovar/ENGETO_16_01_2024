CREATE OR REPLACE TABLE t_renata_kratochvilova_project_SQL_primary_final AS
	WITH payroll_table_final AS (
		WITH payroll_table AS (
			SELECT 
				cp.payroll_year ,
				cp.industry_branch_code ,
				round(avg(value)) AS avg_payroll
			FROM czechia_payroll cp 
			WHERE cp.payroll_year >=2006
				AND cp.payroll_year <=2018
				AND cp.value_type_code = 5958
				AND cp.calculation_code = 200
				AND cp.industry_branch_code IS NOT NULL
			GROUP BY cp.payroll_year, cp.industry_branch_code 
			ORDER BY cp.payroll_year ASC 
		)
		SELECT 
			pt.payroll_year AS `year`,
			cpib.name AS industry_branch,
			pt.avg_payroll
		FROM payroll_table pt
		JOIN czechia_payroll_industry_branch cpib
			ON cpib.code=pt.industry_branch_code
		ORDER BY pt.payroll_year ASC, cpib.name ASC
	),
	price_table_final AS (
		WITH price_table AS (
			SELECT 
				year(date_from) AS `year`,
				category_code ,
				round(avg(value),2) AS avg_price
			FROM czechia_price cp 
			WHERE category_code !='212101'
			AND region_code IS NOT NULL 
			GROUP BY year(date_from), category_code 
		)
		SELECT 
			prt.`year`,
			cpc.name,
			cpc.price_value ,
			cpc.price_unit ,
			prt.avg_price
		FROM price_table prt
		JOIN czechia_price_category cpc
			ON prt.category_code = cpc.code 
	)
	SELECT
		ptf.*,
		prtf.name,
		prtf.price_value,
		prtf.price_unit,
		prtf.avg_price
	FROM payroll_table_final ptf
	JOIN price_table_final prtf
		ON ptf.`year` = prtf.`year`
	ORDER BY ptf.`year` ASC, ptf.industry_branch ASC
;