#standardSQL
# 07_12: Percentiles of TLS negotiation time
SELECT
  client,
  ROUND(APPROX_QUANTILES(tlstime, 1000)[OFFSET(100)] / 1000, 2) AS p10,
  ROUND(APPROX_QUANTILES(tlstime, 1000)[OFFSET(250)] / 1000, 2) AS p25,
  ROUND(APPROX_QUANTILES(tlstime, 1000)[OFFSET(500)] / 1000, 2) AS p50,
  ROUND(APPROX_QUANTILES(tlstime, 1000)[OFFSET(750)] / 1000, 2) AS p75,
  ROUND(APPROX_QUANTILES(tlstime, 1000)[OFFSET(900)] / 1000, 2) AS p90
FROM 
( 
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(payload, "$.timings.ssl") AS INT64) AS tlstime
  FROM
    `httparchive.requests.2019_07_01_*`
)
WHERE
  tlstime != -1
GROUP BY
  client
