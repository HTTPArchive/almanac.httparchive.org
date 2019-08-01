/*
standard SQL
08_01
Reshape without "rank" from https://discuss.httparchive.org/t/adoption-of-http-security-headers-on-the-web/1259
Calculate usage percentage for each of the 10 metrics
BigQuery usage notes: 
  === archive table (limited data available == 20.2 M
     no cross-origin-response-policy, ross-origin-opener-policy, sec-fetch-*
  === live tables (2019_07_01_*) = 124.9 GB 
*/



SELECT 
      count(distinct p.pageid) pages,
       ROUND(SUM(IF(LOWER(r.respOtherHeaders) LIKE "%nel = %",1,0))/count(distinct p.pageid),3) NEL,
       ROUND(SUM(IF(LOWER(r.respOtherHeaders) LIKE "%report-to = %",1,0))/count(distinct p.pageid),3) ReportTo, 
       ROUND(SUM(IF(LOWER(r.respOtherHeaders) LIKE "%referrer-policy = %",1,0))/count(distinct p.pageid),3) ReferrerPolicy, 
       ROUND(SUM(IF(LOWER(r.respOtherHeaders) LIKE "%feature-policy = %",1,0))/count(distinct p.pageid),3) FeaturePolicy,
       ROUND(SUM(IF(LOWER(r.respOtherHeaders) LIKE "%x-content-type-options = %",1,0))/count(distinct p.pageid),3) XContentTypeOptions,
       ROUND(SUM(IF(LOWER(r.respOtherHeaders) LIKE "%x-xss-protection = %",1,0))/count(distinct p.pageid),3) XXssProtection,
       ROUND(SUM(IF(LOWER(r.respOtherHeaders) LIKE "%x-frame-options = %",1,0))/count(distinct p.pageid),3) XFrameOptions,
       ROUND(SUM(IF(LOWER(r.respOtherHeaders) LIKE "%cross-origin-response-policy = %",1,0))/count(distinct p.pageid),3) XOriginResponsePolicy,
       ROUND(SUM(IF(LOWER(r.respOtherHeaders) LIKE "%cross-origin-opener-policy = %",1,0))/count(distinct p.pageid),3) XOriginOpenerPolicy,
       ROUND(SUM(IF(LOWER(r.respOtherHeaders) LIKE "%sec-fetch-%:%",1,0))/count(distinct p.pageid),3) SecFetch
FROM `httparchive.almanac.summary_requests_*` r 
JOIN (
   SELECT rank, pageid FROM `httparchive.almanac.summary_pages_*`
   ) as p 
ON p.pageid = r.pageid
 WHERE firstHtml = true
