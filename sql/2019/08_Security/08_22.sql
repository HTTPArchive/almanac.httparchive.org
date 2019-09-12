#standardSQL
# 08_20: HSTS - variance in max-age
SELECT 
  percentile percentile,
  APPROX_QUANTILES(max_age, 1000)[OFFSET(percentile*10)] AS max_age 
  FROM
  (
    SELECT 
      CAST(REGEXP_EXTRACT(REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?strict-transport-security =([^,]+)'), r'(?i)max-age= *-?(\d+)') AS INT64) max_age
      FROM
        `httparchive.summary_requests.2019_07_01_*`
      WHERE 
        firstHtml = true AND
        REGEXP_CONTAINS(LOWER(respOtherHeaders), 'strict-transport-security')
   ),
  UNNEST([10,25,50,75,90]) AS percentile
GROUP BY 
  percentile
ORDER BY 
  percentile
