

WITH GDP_growth AS (
	WITH GDP_table AS (
		SELECT 
			st.`year`,
			st.GDP
		FROM t_renata_kratochvilova_project_sql_secondary_final st
		WHERE st.country = 'Czech Republic'
	),
	GDP_table_prev_year AS (
		SELECT 
			*
		FROM t_renata_kratochvilova_project_sql_secondary_final st2
		WHERE st2.country = 'Czech Republic'
	)
	SELECT 
		gt.`year`,
		gt.GDP,
		gt2.GDP AS GDP_prev_year,
		round((gt.GDP - gt2.GDP)/gt2.GDP*100,2) AS GDP_growth
	FROM GDP_table gt
	JOIN GDP_table_prev_year gt2
		ON gt.`year` = gt2.`year` + 1
)
SELECT 
	gg.`year`,
	gg.GDP_growth,
	ppg.price_growth,
	ppg.payroll_growth
FROM GDP_growth gg
JOIN v_price_payroll_growth ppg
	ON ppg.`year` = gg.`year`
ORDER BY gg.`year`
;










