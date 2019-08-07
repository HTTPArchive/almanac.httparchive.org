#StandardSQL
/*
09_05

10TB

only tested on the 10k sample response body samples
FROM the sample data
Get the aria roles - AND the tags that contain them.  
(this is NOT a perfect query - AS some are too long, AND probably some areas are grabbed 2x)

get the LENGTH of the body, AND the SUM of the LENGTHs of all the roles - AND find the percentage that are ariacovered

then calculate the percentiles of he percentages of ARia coverage
*/
SELECT Approx_quantiles(percentgearia, 11)
FROM(

SELECT url, bodyLENGTH, SUM(roleLENGTH) SUMroles, SUM(roleLENGTH)/bodyLENGTH*100 percentgearia
FROM(
SELECT url, BYTE_LENGTH(flat_ariaenclosed) roleLENGTH, BYTE_LENGTH(body) bodyLENGTH
FROM(

SELECT
      url, 
      REGEXP_EXTRACT_ALL(LOWER(body),r'<?.*role=[\'"]*[^\s\'"]+[\'"]*.*?>') ariaenclosed,
      body
FROM `response_bodies.2019_07_01_*` 
WHERE LOWER(body) LIKE "%role=%"

)
CROSS JOIN UNNEST(ariaenclosed) flat_ariaenclosed
GROUP BY url, flat_ariaenclosed, body
)
GROUP BY url, bodyLENGTH
ORDER BY SUM(roleLENGTH)/bodyLENGTH*100 desc
)