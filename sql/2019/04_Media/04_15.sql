#standardSQL
/*
standard sql

04_15
13 GB


how many movies.. how big (in percentiles by extension).. 

remove the percentiles to get a better COUNT for each format.
remove the ext AND cnter to get a better idea on sizes.



*/

SELECT ext, client,
        COUNT(*) AS cnter, 
        APPROX_QUANTILES(respsize,11) AS sizepercentiles

FROM(

SELECT url, respsize, ext, mimetype, format, _TABLE_SUFFIX AS client

FROM `summary_requests.2019_07_01_*` 
WHERE mimetype LIKE "%video%"
)
GROUP BY format, ext, client
ORDER BY cnter desc