
-- FINAL
CREATE OR REPLACE VIEW v_price_payroll_growth AS 
WITH total_price_change AS (
	WITH price_change AS (
		SELECT 
			pf.`year`,
			pf.name,
			round((avg(pf.avg_price)-avg(pf2.avg_price))/avg(pf2.avg_price)*100,2) AS change_price
		FROM t_renata_kratochvilova_project_sql_primary_final pf
		JOIN t_renata_kratochvilova_project_sql_primary_final pf2
			ON pf2.name = pf.name
			AND pf2.`year` + 1 = pf.`year`
		GROUP BY pf.`year`, pf.name
		ORDER BY pf.name,pf.`year`
		)
	SELECT 
		`year`,
		round(avg(change_price),2) AS price_growth
	FROM price_change pc
	GROUP BY `year` 	
),
payroll_change AS (
	SELECT 
		pf.`year` ,
		pf2.`year` + 1 AS year_prev,
		round((avg(pf.avg_payroll ) - avg(pf2.avg_payroll)) / avg(pf2.avg_payroll) * 100,2) AS payroll_growth
	FROM t_renata_kratochvilova_project_sql_primary_final pf
	JOIN t_renata_kratochvilova_project_sql_primary_final pf2 
		ON pf.industry_branch = pf2.industry_branch 
		AND pf.`year` = pf2.`year` + 1
	GROUP BY pf.`year`
	ORDER BY `year` 
)
SELECT 
	tpc.*,
	pc.payroll_growth,
	tpc.price_growth - pc.payroll_growth AS Diff
FROM total_price_change tpc
JOIN payroll_change pc
	ON pc.`year` = tpc.`year`
ORDER BY Diff DESC 
;




