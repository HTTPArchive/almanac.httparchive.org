#standardSQL
/*
standard SQL
04_09b
10 TB

looks for "Accept-CH" in the body of a response.  

Not filtering on head, OR  meta tags, AS other instaces are unlikely.
Only 3 hits in the 1K mobile response body sample set
*/


SELECT url,body, _TABLE_SUFFIX AS client,


FROM `response_bodies.2019_07_01_*`
WHERE body LIKE "%Accept-CH%"
