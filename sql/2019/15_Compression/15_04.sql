SELECT mimeType, count(*) total,
       SUM(IF(resp_content_encoding = "gzip",1,0)) gzip,
       SUM(IF(resp_content_encoding = "br",1,0)) brotli,
       SUM(IF(resp_content_encoding = "deflate",1,0)) deflate,
       SUM(IF(resp_content_encoding IN("gzip","deflate","br"),0,1)) NoTextCompression,
       ROUND(
           SUM(
               IF(resp_content_encoding IN("gzip", "deflate", "br"),1,0)
           ) / COUNT(*),2) CompressedPercentage,
       ROUND(
           SUM(
               IF(resp_content_encoding = "br",1,0)
            ) / COUNT(*),2) BrotliCompressedPercentage
FROM `httparchive.summary_requests.2019_07_01_mobile`   
GROUP BY mimeType
HAVING total > 1000
ORDER BY total DESC
