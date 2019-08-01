/*
09_03

10TB
headings  <h1> -> <h6>
this gives the final totals.  If we unwind the query we can break down count by url.

only tested on the sample data set
*/


select url, flat_heading, count(flat_heading) cnt from
(
select url, heading from (
select
url, REGEXP_EXTRACT_ALL(lower(body),r'(<h[1-6]>)') heading
from `response_bodies.2019_07_01_mobile` 

)
where array_length(heading) >0
order by array_length(heading) desc
)
cross join unnest(heading) flat_heading
group by url, flat_heading
order by url desc, cnt desc
