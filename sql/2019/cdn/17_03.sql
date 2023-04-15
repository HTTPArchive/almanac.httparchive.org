#standardSQL
# 07_03: Percentiles of TTFB for CDN
SELECT
  client,
  cdn,
  COUNT(0) AS requests,
  APPROX_QUANTILES(ttfb, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(ttfb, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(ttfb, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(ttfb, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(ttfb, 1000)[OFFSET(900)] AS p90
FROM (
  SELECT
    client,
    CAST(JSON_EXTRACT(payload, '$._ttfb_ms') AS INT64) AS ttfb,
    _cdn_provider AS cdn
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    _cdn_provider != ''
)
GROUP BY
  client,
  cdn
ORDER BY
  requests DESC
