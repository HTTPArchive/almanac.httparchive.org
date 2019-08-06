/*
09_15

10TB

only tested on the 10k sample response body samples
look for all input fields.
then also look for input fields with 'aria-required' or 'aria-invalid'
get quantiles and sum of total inputs

*/
select approx_quantiles(ariarequired, 5) ariareqquantiles,
       approx_quantiles(ariainvalid, 5)  ariainvalidquantiles,
       approx_quantiles(allinputs, 5)  allinputsquantiles,
       sum(ariarequired) requiredsum,
       sum(ariainvalid) ariainvalidsum,
       sum(allinputs) allinputssum

from(
select url, array_length(ariarequired) ariarequired,
            array_length(ariainvalid) ariainvalid,
            array_length(allinputs) allinputs
from(
select
url, 
REGEXP_EXTRACT_ALL(lower(body),r'(<input.*aria-required.*/>)') ariarequired,
REGEXP_EXTRACT_ALL(lower(body),r'(<input.*aria-invalid.*/>)') ariainvalid,
REGEXP_EXTRACT_ALL(lower(body),r'(<input.*/>)') allinputs
from `response_bodies.2019_07_01_mobile` 
where lower(body) like "%<input%"
))