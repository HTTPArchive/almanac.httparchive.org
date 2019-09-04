#standardSQL
# 07_03: Percentiles of TTFB for CDN
SELECT
  client,
  cdn,
  ROUND(APPROX_QUANTILES(ttfb, 1000)[OFFSET(100)] / 1000, 2) AS p10,
  ROUND(APPROX_QUANTILES(ttfb, 1000)[OFFSET(250)] / 1000, 2) AS p25,
  ROUND(APPROX_QUANTILES(ttfb, 1000)[OFFSET(500)] / 1000, 2) AS p50,
  ROUND(APPROX_QUANTILES(ttfb, 1000)[OFFSET(750)] / 1000, 2) AS p75,
  ROUND(APPROX_QUANTILES(ttfb, 1000)[OFFSET(900)] / 1000, 2) AS p90
FROM 
( 
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(payload, "$._ttfb_ms") AS INT64) AS ttfb,
    RTRIM(LTRIM(JSON_EXTRACT_SCALAR(payload, '$._cdn_provider'))) AS cdn
  FROM
    `httparchive.requests.2019_07_01_*`
)
WHERE
  cdn != ''
GROUP BY
  client, cdn
