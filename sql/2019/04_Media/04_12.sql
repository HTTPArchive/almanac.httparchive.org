#standardSQL
/*
standard SQL
04_12
112 GB

this gets the requests whose servers add a "Vary: User-Agent" OR  "Vary: Accept" 
(not a lot of hits here... many have Vary: Accept-Encoding)

*/


SELECT url, NET.HOST(url) host, respOtherHeaders


FROM `summary_requests.2019_07_01_*`
WHERE respOtherHeaders LIKE "%Vary:%User-Agent%" OR respOtherHeaders LIKE "%Vary:%Accept%"
ORDER BY HOST ASC