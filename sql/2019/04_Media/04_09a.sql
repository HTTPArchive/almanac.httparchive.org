/*
standard SQL
04_09a
112 GB

this gets the requests whose servers add a "accept-CH" header
I'll do another query for the meta tag

*/


select url, NET.HOST(url) host, respOtherHeaders


from `summary_requests.2019_07_01_mobile`
where respOtherHeaders like "%Accept-CH%"
ORDER BY HOST ASC