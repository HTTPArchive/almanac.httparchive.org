#standardSQL
/*
09_13
standardsql
10TB
only tested on sample data

headings  <h1> -> <h6>
are heading levels out of ORDER?
the GetNames AND COUNTs fills an array in ORDER of the way the headings appear, 
so AS long AS that array is in ORDER, the arrangement of headings in the page is ok
<h1>
<h2>
<h1>
is ok

<h2>
<h1> 
is NOT ok.

This query is a bit convoluted.  Sorry about that :)

there are 2 similar queries that are JOINed.
both run a regex to get all of the headings in the body.
then I run GetNumberOnly to strip out the < h AND > AND only the first occurence of each
here the queries divide
- - - - -- - - 
ORDERed query takes this list AND ORDERs them FROM 1->6
UNNESTs the array of numbers in to a comma seperated string

-------
h query takes the list AS FROM the body of the doc into a comma seperated string
--- - - - - - - - - -
if the ORDER is correct - thr ORDERed list will match the h query.
if they are out of ORDER - the if will give a 0
then SUM up "all sites" (COUNT)
     SUM up all ones - headings in ORDER

*/
CREATE TEMP FUNCTION GetNumberOnly(elements ARRAY<STRING>) AS (
  ARRAY(
    SELECT  trim(elem,"<h>") 
    FROM UNNEST(elements) AS elem
    GROUP BY elem
  )
);

SELECT COUNT(*) AS COUNT, SUM(inORDER)  AS sitesheadingsinORDER
FROM(
SELECT url, if (ORDERed = hnumber,1,0) AS inORDER
FROM(

/* get the array with < h AND > removed, nad also create the ORDERed version*/
SELECT ORDERed.url, 
	   ORDERed.ORDERed, 
	   hnumber.hnumber

FROM
(SELECT url, string_agg(flat_hORDERed, ",") ORDERed
FROM(
SELECT url,   
       heading, 
       /*GetNumberOnly(heading) AS hnumber*/
       ARRAY(SELECT x FROM UNNEST(GetNumberOnly(heading)) AS x ORDER BY x) AS hORDERed

FROM (
SELECT
url, REGEXP_EXTRACT_ALL(LOWER(body),r'(<h[1-6]>)') heading
FROM `response_bodies.2019_07_01_mobile` 
)
WHERE ARRAY_LENGTH(heading) >1 
) CROSS JOIN UNNEST(hORDERed) AS flat_hORDERed
GROUP BY url) ORDERed


JOIN


(SELECT url, string_agg(flat_hnumber, ",") hnumber
FROM(
SELECT url,   
       heading, 
       GetNumberOnly(heading) AS hnumber
       /*ARRAY(SELECT x FROM UNNEST(GetNumberOnly(heading)) AS x ORDER BY x) AS hORDERed*/

FROM (
SELECT
url, REGEXP_EXTRACT_ALL(LOWER(body),r'(<h[1-6]>)') heading
FROM `response_bodies.2019_07_01_*` 
)
WHERE ARRAY_LENGTH(heading) >1 
) CROSS JOIN UNNEST(hnumber) AS flat_hnumber
GROUP BY url) hnumber
on(hnumber.url = ORDERed.url)
))