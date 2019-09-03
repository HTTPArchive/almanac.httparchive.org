#standardSQL
# 17_04: Percentiles of header volume
SELECT
  client,
  ROUND(APPROX_QUANTILES(reqheader, 1000)[OFFSET(100)] / 1024, 2) AS p10_reqheader,
  ROUND(APPROX_QUANTILES(reqheader, 1000)[OFFSET(250)] / 1024, 2) AS p25_reqheader,
  ROUND(APPROX_QUANTILES(reqheader, 1000)[OFFSET(500)] / 1024, 2) AS p50_reqheader,
  ROUND(APPROX_QUANTILES(reqheader, 1000)[OFFSET(750)] / 1024, 2) AS p75_reqheader,
  ROUND(APPROX_QUANTILES(reqheader, 1000)[OFFSET(900)] / 1024, 2) AS p90_reqheader,
  ROUND(APPROX_QUANTILES(resheader, 1000)[OFFSET(100)] / 1024, 2) AS p10_resheader,
  ROUND(APPROX_QUANTILES(resheader, 1000)[OFFSET(250)] / 1024, 2) AS p25_resheader,
  ROUND(APPROX_QUANTILES(resheader, 1000)[OFFSET(500)] / 1024, 2) AS p50_resheader,
  ROUND(APPROX_QUANTILES(resheader, 1000)[OFFSET(750)] / 1024, 2) AS p75_resheader,
  ROUND(APPROX_QUANTILES(resheader, 1000)[OFFSET(900)] / 1024, 2) AS p90_resheader
FROM 
( 
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(payload, '$.request.headersSize') AS INT64) AS reqheader,
    CAST(JSON_EXTRACT(payload, '$.response.headersSize') AS INT64) AS resheader
  FROM
    `httparchive.requests.2019_07_01_*`
)
GROUP BY
  client
