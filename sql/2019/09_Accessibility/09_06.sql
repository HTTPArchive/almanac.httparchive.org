/*
09_06
10TB
only tested on the sample data set

extracts all id="*" fields from every website.  
flattens the dataset, and then counts for duplicates.
The final result shows how many IDs appear counter times on the page
using the sample_data.response_bodies_mobile_10k
there are 777,252 ids that occur just once
           51,450 ids that appear twice (on one page)
           13,978 appear 3x
           and so on
           
           a googlead ID appears 5560 times on 3 different sides

*/

select counter, count (*) from(

select url, flat_ids , count(flat_ids) counter from(
select
url, regexp_extract_all(lower(body),r'(id=["\']*[^\s\'"]*["\']*)') ids
from `response_bodies.2019_07_01_mobile` 
where lower(body) like "%id=%"  )
cross join unnest(ids) flat_ids
group by url, flat_ids
order by counter desc

)
group by counter
order by counter asc