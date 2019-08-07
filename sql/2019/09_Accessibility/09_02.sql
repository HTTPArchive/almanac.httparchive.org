#StandardSQL
/*
09_02

10TB

only tested on the 10k sample response body samples
FROM the sample data
20,651 urls have aria roles
there are 132,658 aria roles on those pages
34514 of these are unique, AND the query below gives the COUNT of each role on each page.

save this AS a table to further dig into the data
*/
SELECT url, 
		flat_ariarole, 
		COUNT(flat_ariarole) AS COUNTer
FROM(
SELECT
	url, 
	REGEXP_EXTRACT_ALL(LOWER(body),r'(role=['"]*[^\s\'"]+?['"]*)') AS ariarole
FROM `response_bodies.2019_07_01_*` 
WHERE LOWER(body) LIKE "%role=%"
)
CROSS JOIN UNNEST(ariarole) flat_ariarole
GROUP BY url, flat_ariarole
ORDER BY url desc, COUNTer desc