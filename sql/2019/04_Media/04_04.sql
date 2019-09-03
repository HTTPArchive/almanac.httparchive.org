#standardSQL
/*


10 TB query  
NB: I have only tested this on the mobile 1k sample data...it worked there

this query looks in all response bodies for <svg *  /svg> tags 
in a non greedy way - so we get all the SVGs that are inline.
i then UNNEST the SVGS FROM the array, AND calculate the LENGTH
and get percentiles (and total COUNT).


*/
SELECT
    APPROX_QUANTILES(svgCOUNT, 1000)[offset(250)] AS p25count,
    APPROX_QUANTILES(svgCOUNT, 1000)[offset(500)] AS p50count,
    APPROX_QUANTILES(svgCOUNT, 1000)[offset(750)] AS p75count,
    APPROX_QUANTILES(svgCOUNT, 1000)[offset(900)] AS p90count,
    COUNT(url) AS pageCOUNT,
    APPROX_QUANTILES(svglen, 1000)[offset(250)] AS p25length,
    APPROX_QUANTILES(svglen, 1000)[offset(500)] AS p50length,
    APPROX_QUANTILES(svglen, 1000)[offset(750)] AS p75length, 
    APPROX_QUANTILES(svglen, 1000)[offset(900)] AS p90length
FROM(
SELECT url, COUNT(flat_svgs) AS svgCOUNT, svglen
FROM(

SELECT url, flat_svgs , LENGTH(flat_svgs) AS svglen

FROM(
(SELECT url, REGEXP_EXTRACT_ALL(LOWER(body),r'(<svg.*?/svg>)') svgs
FROM `almanac.summary_response_bodies`  svglist
WHERE body LIKE "%<svg%" AND url NOT LIKE "%svg" AND type = 'html')
)
CROSS JOIN UNNEST(svgs) AS flat_svgs
/*
need these when UNNESTing the queries
GROUP BY url, flat_svgs
ORDER BY url asc
*/
)GROUP BY url, svglen
)