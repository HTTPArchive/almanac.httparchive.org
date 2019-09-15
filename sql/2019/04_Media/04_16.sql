#StandardSQL
/*
standard sql

04_16
60 GB


how many movies.. using Youtube
The query is currently set to NOT YouTube
Deleting the NOT in LIKE 24 gives YES YouTube



*/

SELECT ext, client, COUNT(*) cnter


FROM(

SELECT url, respsize, ext, mimetype, format, _TABLE_SUFFIX AS client

FROM `summary_requests.2019_07_01_*` 
WHERE mimetype LIKE "%video%" AND url NOT LIKE "%youtube%"
)
GROUP BY format, ext, client
ORDER BY cnter desc