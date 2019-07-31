/*
standard sql

10 TB query  
NB: I have only tested this on the mobile 1k sample data...it worked there

this query looks in all response bodies for <svg *  /svg> tags 
in a non greedy way - so we get all the SVGs that are inline.
i then unnest the SVGS from the array, and calculate the length
and get percentiles (and total count).


*/
select
    approx_quantiles(svgCount, 1000)[offset(250)] as p25,
    approx_quantiles(svgCount, 1000)[offset(500)] as p50,
    approx_quantiles(svgCount, 1000)[offset(750)] as p75,
    approx_quantiles(svgCount, 1000)[offset(900)] as p90,
    count(url) as pagecount
from(
select url, count(flat_svgs) AS svgCount
from(

select url, flat_svgs , length(flat_svgs) svglen

from(
(select url, REGEXP_EXTRACT_ALL(body,r'(<svg.*?/svg>)') svgs
from `response_bodies.2019_07_01_mobile`  svglist
where body like "%<svg%" and url not like "%svg") 
)
cross join UNNEST(svgs) AS flat_svgs
/*
need these when unnesting the queries
group by url, flat_svgs
order by url asc
*/
)group by url
)