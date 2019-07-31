/*
standard SQL
04_03b

5.25 gb query

how many SVG files are requested as discrete files (5.1M)
and breakdown of SVG filesize in 2% buckets

*/
select 
    approx_quantiles(count, 1000)[offset(250)] as p25,
    approx_quantiles(count, 1000)[offset(500)] as p50,
    approx_quantiles(count, 1000)[offset(750)] as p75,
    approx_quantiles(count, 1000)[offset(900)] as p90,
    count(pageid) as pagecount
 from(
select  pageid,
        count(*) count
from(

select url, pageid, respsize, ext, format

from `httparchive.summary_requests.2019_07_01_mobile`
where ext ="svg")
group by pageid)