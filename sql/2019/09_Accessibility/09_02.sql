/*
09_02

10TB

only tested on the 10k sample response body samples
from the sample data
20,651 urls have aria roles
there are 132,658 aria roles on those pages
34514 of these are unique, and the query below gives the count of each role on each page.

save this as a table to further dig into the data
*/
select url, flat_ariarole, count(flat_ariarole) counter
from(
select
url, REGEXP_EXTRACT_ALL(body,r'(role="[\s\S]+?")') ariarole
from `response_bodies.2019_07_01_mobile` 
where body like "%role=%"
)
cross join unnest(ariarole) flat_ariarole
group by url, flat_ariarole
order by url desc, counter desc