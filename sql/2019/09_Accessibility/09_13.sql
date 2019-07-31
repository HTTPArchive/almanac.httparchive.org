/*
09_13
standardsql
10TB
only tested on sample data

headings  <h1> -> <h6>
are heading levels out of order?
the GetNames and counts fills an array in order of the way the headings appear, 
so as long as that array is in order, the arrangement of headings in the page is ok
<h1>
<h2>
<h1>
is ok

<h2>
<h1> 
is not ok.

This query is a bit convoluted.  Sorry about that :)

there are 2 similar queries that are joined.
both run a regex to get all of the headings in the body.
then I run GetNumberOnly to strip out the < h and > and only the first occurence of each
here the queries divide
- - - - -- - - 
ordered query takes this list and orders them from 1->6
unnests the array of numbers in to a comma seperated string

-------
h query takes the list as from the body of the doc into a comma seperated string
--- - - - - - - - - -
if the order is correct - thr ordered list will match the h query.
if they are out of order - the if will give a 0
then sum up "all sites" (count)
     sum up all ones - headings in order

*/
CREATE TEMP FUNCTION GetNumberOnly(elements ARRAY<STRING>) AS (
  ARRAY(
    SELECT  trim(elem,"<h>") 
    FROM UNNEST(elements) AS elem
    GROUP BY elem
  )
);

select count(*) count, sum(inorder) sitesheadingsinorder
from(
select url, if (ordered = hnumber,1,0) inorder
from(

/* get the array with < h and > removed, nad also create the ordered version*/
select ordered.url, ordered.ordered, hnumber.hnumber

from
(select url, string_agg(flat_hordered, ",") ordered
from(
select url,   
       heading, 
       /*GetNumberOnly(heading) AS hnumber*/
       ARRAY(SELECT x FROM UNNEST(GetNumberOnly(heading)) AS x ORDER BY x) AS hordered

from (
select
url, REGEXP_EXTRACT_ALL(lower(body),r'(<h[1-6]>)') heading
from `response_bodies.2019_07_01_mobile` 
)
where array_length(heading) >1 
) cross join unnest(hordered) as flat_hordered
group by url) ordered


join


(select url, string_agg(flat_hnumber, ",") hnumber
from(
select url,   
       heading, 
       GetNumberOnly(heading) AS hnumber
       /*ARRAY(SELECT x FROM UNNEST(GetNumberOnly(heading)) AS x ORDER BY x) AS hordered*/

from (
select
url, REGEXP_EXTRACT_ALL(lower(body),r'(<h[1-6]>)') heading
from `response_bodies.2019_07_01_mobile` 
)
where array_length(heading) >1 
) cross join unnest(hnumber) as flat_hnumber
group by url) hnumber
on(hnumber.url = ordered.url)
))