#standardSQL
/*
standard SQL
04_03b

5.25 gb query

how many SVG files are requested AS discrete files (5.1M)
and breakdown of SVG filesize in 2% buckets

*/
SELECT 
    APPROX_QUANTILES(COUNT, 1000)[offset(250)] AS p25,
    APPROX_QUANTILES(COUNT, 1000)[offset(500)] AS p50,
    APPROX_QUANTILES(COUNT, 1000)[offset(750)] AS p75,
    APPROX_QUANTILES(COUNT, 1000)[offset(900)] AS p90,
    COUNT(pageid) AS pageCOUNT
 FROM(
SELECT  pageid,
        COUNT(*) COUNT
FROM(

SELECT url, pageid, respsize, ext, format

FROM `httparchive.summary_requests.2019_07_01_mobile`
WHERE ext ="svg")
GROUP BY pageid)