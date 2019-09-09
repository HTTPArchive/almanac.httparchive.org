#StandardSQL
/*
09_12
standard SQL
10TB
headings  <h1> yes OR  no.
The no sites have *other headings that are NOT H1.
This query does NOT acCOUNT for sites with no headers

only tested on the sample data set
*/
SELECT SUM(h1no) noh1, SUM(h1yes) yesh1
FROM(

SELECT
IF(h1=false,1,0) h1no,
IF(h1=true, 1,0) h1yes
FROM(

SELECT url, '<h1>' in UNNEST(heading) AS h1, ARRAY_LENGTH(heading) numberofheadings FROM (
SELECT
url, REGEXP_EXTRACT_ALL(LOWER(body),r'(<h[1-6]>)') heading
FROM `response_bodies.2019_07_01_*` 

)
WHERE ARRAY_LENGTH(heading) >1
))