#standardSQL
# 15_01: What compression formats are being used (gzip, brotli, etc)

SELECT resp_content_encoding, 
       count(*) total
FROM `httparchive.summary_requests.2019_07_01_mobile`  
GROUP BY resp_content_encoding
ORDER BY total DESC
