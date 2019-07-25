/*
standard SQL
04_03

5.25 gb query

how many SVG files are requested as discrete files (5.1M)
and breakdown of SVG filesize in 2% buckets

*/

select APPROX_QUANTILES(respsize, 50) size, count(*) count
from(

select url, respsize, ext, format

from `httparchive.summary_requests.2019_07_01_mobile`
where ext ="svg")
