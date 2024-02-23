
WITH price_2006 AS (
	SELECT 
		`year`,
		name,
		avg(avg_price) AS avg_price_06
	FROM t_renata_kratochvilova_project_sql_primary_final trkpspf 
	WHERE `year` = '2006'
	GROUP BY `year`, name
),
price_2018 AS (
	SELECT 
		`year`,
		name,
		avg(avg_price) AS avg_price_18
	FROM t_renata_kratochvilova_project_sql_primary_final trkpspf 
	WHERE `year` = '2018'
	GROUP BY `year`, name
)
SELECT 
	p.name,
	p.avg_price_06,
	p2.avg_price_18,
	round((p2.avg_price_18-p.avg_price_06)/p.avg_price_06*100,2) AS change_in_perc
FROM price_2006 p
JOIN price_2018 p2
ON p2.name = p.name
ORDER BY change_in_perc ASC 
;









