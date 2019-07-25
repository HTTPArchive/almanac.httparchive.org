/*
09_11
standardsql
10TB
only tested on sample data

headings  <h1> -> <h6>
are heading levels skipped?
break down presence of headers in each website to true or false
then if a top level is false, blut a lower level heading is true - they are out of order - give value 1
if they are correctly ordered - give a 0
if the sum of all of these is >0 - at least one heading is placed out of order.
so the total out of order is found, vs all sites with headings
*/
select
sum(outoforder) totalouroforder, count(*) allsites
from(
select
if(h1+h2+h3+h4+h5 >0, 1, 0) outoforder
from(
select
if(h1=false and (h2 = true or h3=true or h4=true or h5=true or h6=true),1, 0) h1,
if(h2=false and (h3=true or h4=true or h5=true or h6=true),1, 0) h2,
if(h3=false and (h4=true or h5=true or h6=true),1, 0) h3,
if(h4=false and (h5=true or h6=true),1, 0) h4,
if(h5=false and (h6=true),1, 0) h5
from(
select url, '<h1>' in UNNEST(heading) as h1, 
             '<h2>' in UNNEST(heading) as h2, 
             '<h3>' in UNNEST(heading) as h3, 
             '<h4>' in UNNEST(heading) as h4, 
             '<h5>' in UNNEST(heading) as h5, 
             '<h6>' in UNNEST(heading) as h6, 
             array_length(heading) numberofheadings from (
select
url, REGEXP_EXTRACT_ALL(lower(body),r'(<h[1-6]>)') heading
from `response_bodies.2019_07_01_mobile` 

)
where array_length(heading) >1
)))