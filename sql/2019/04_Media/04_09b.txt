/*
standard SQL
04_09b
10 TB

looks for "Accept-CH" in the body of a response.  

Not filtering on head, or meta tags, as other instaces are unlikely.
Only 3 hits in the 1K mobile response body sample set
*/


select url,body


from `response_bodies.2019_07_01_mobile`
where body like "%Accept-CH%"
