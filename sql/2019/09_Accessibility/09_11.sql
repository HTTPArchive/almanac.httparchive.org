#StandardSQL
/*
09_11
standardsql
10TB
only tested on sample data

headings  <h1> -> <h6>
are heading levels skipped?
break down presence of headers in each website to true OR  false
then if a top level is false, blut a LOWER level heading is true - they are out of ORDER - give value 1
if they are correctly ORDERed - give a 0
if the SUM of all of these is >0 - at least one heading is placed out of ORDER.
so the total out of ORDER is found, vs all sites with headings
*/
SELECT
SUM(outofORDER) totalourofORDER, COUNT(*) allsites
FROM(
SELECT
IF(h1+h2+h3+h4+h5 >0, 1, 0) outofORDER
FROM(
SELECT
IF(h1=false AND (h2 = true OR  h3=true OR  h4=true OR  h5=true OR  h6=true),1, 0) h1,
IF(h2=false AND (h3=true OR  h4=true OR  h5=true OR  h6=true),1, 0) h2,
IF(h3=false AND (h4=true OR  h5=true OR  h6=true),1, 0) h3,
IF(h4=false AND (h5=true OR  h6=true),1, 0) h4,
IF(h5=false AND (h6=true),1, 0) h5
FROM(
SELECT url, '<h1>' in UNNEST(heading) AS h1, 
             '<h2>' in UNNEST(heading) AS h2, 
             '<h3>' in UNNEST(heading) AS h3, 
             '<h4>' in UNNEST(heading) AS h4, 
             '<h5>' in UNNEST(heading) AS h5, 
             '<h6>' in UNNEST(heading) AS h6, 
             ARRAY_LENGTH(heading) numberofheadings FROM (
SELECT
url, REGEXP_EXTRACT_ALL(LOWER(body),r'(<h[1-6]>)') heading
FROM `response_bodies.2019_07_01_*` 

)
WHERE ARRAY_LENGTH(heading) >1
)))