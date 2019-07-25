/*
standard SQL
04_12
112 GB

this gets the requests whose servers add a "Vary: User-Agent" or "Vary: Accept" 
(not a lot of hits here... many have Vary: Accept-Encoding)

*/


select url, NET.HOST(url) host, respOtherHeaders


from `summary_requests.2019_07_01_mobile`
where respOtherHeaders like "%Vary:%User-Agent%" OR respOtherHeaders like "%Vary:%Accept%"
ORDER BY HOST ASC