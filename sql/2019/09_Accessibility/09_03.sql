#StandardSQL
/*
09_03

10TB
headings  <h1> -> <h6>
this gives the final totals.  If we unwind the query we can break down COUNT by url.

only tested on the sample data set
*/


SELECT url, flat_heading, COUNT(flat_heading) cnt FROM
(
SELECT url, heading FROM (
SELECT
url, REGEXP_EXTRACT_ALL(LOWER(body),r'(<h[1-6]>)') heading
FROM `response_bodies.2019_07_01_*` 

)
WHERE ARRAY_LENGTH(heading) >0
ORDER BY ARRAY_LENGTH(heading) desc
)
CROSS JOIN UNNEST(heading) flat_heading
GROUP BY url, flat_heading
ORDER BY url desc, cnt desc
