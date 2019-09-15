#standardSQL
/*
standard SQL
04_12
112 GB

this gets the requests whose servers add a "Vary: User-Agent" OR  "Vary: Accept" 
(not a lot of hits here... many have Vary: Accept-Encoding)

*/


SELECT count(distinct(NET.HOST(url))) hostcount


FROM `summary_requests.2019_07_01_*`
WHERE LOWER(resp_vary) IN ('user-agent', 'accept')
