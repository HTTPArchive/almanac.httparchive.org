#StandardSQL
/*
standard SQL
04_09a
112 GB

this gets the requests whose servers add a "accept-CH" header
I'll do another query for the meta tag

*/


SELECT url, 
	NET.HOST(url)AS  host, 
	respOtherHeaders


FROM `summary_requests.2019_07_01_mobile`
WHERE respOtherHeaders LIKE "%Accept-CH%"
ORDER BY HOST ASC