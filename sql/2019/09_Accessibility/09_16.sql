/*
09_15

10TB

only tested on the 10k sample response body samples
from the sample data
look for input foelds with aria_required
save this as a table to further dig into the data
*/
select url,  
       count(flat_ariarequired) countrequired,
       count(ariainvalid) countariainvalid,
       count(flat_inputs) countinputs,
              
from(
select
url, 
REGEXP_EXTRACT_ALL(lower(body),r'(<input.*aria-required.*/>)') ariarequired, 
REGEXP_EXTRACT_ALL(lower(body),r'(<input.*aria-invalid.*/>)') ariainvalid,
REGEXP_EXTRACT_ALL(lower(body),r'(<input.*/>)') inputs,
from `response_bodies.2019_07_01_mobile` 
)
cross join unnest(ariarequired) flat_ariarequired
cross join unnest(ariainvalid) flat_ariainvalid
cross join unnest(inputs) flat_inputs
group by url, flat_ariarequired, flat_ariainvalid, flat_inputs
order by url desc, counter desc