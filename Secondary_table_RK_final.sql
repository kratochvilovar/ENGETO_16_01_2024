CREATE OR REPLACE TABLE t_renata_kratochvilova_project_SQL_secondary_final AS
	SELECT 
		c.country,
		e.`year`,
		e.GDP,
		e.gini,
		e.population 
	FROM countries c
	JOIN economies e 
		ON c.country = e.country
	WHERE continent = 'Europe'
		AND e.`year` >=2006 
		AND e.`year` <=2018
	ORDER BY country ASC, `year` ASC 
;





















