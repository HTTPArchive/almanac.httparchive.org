#standardSQL
# 07_13: Distribution of TLS Certificate size
SELECT
  client,
  cdn,
  COUNT(0) AS requests,
  ROUND(APPROX_QUANTILES(tlscertsize, 1000)[OFFSET(100)] / 1024, 2) AS p10,
  ROUND(APPROX_QUANTILES(tlscertsize, 1000)[OFFSET(250)] / 1024, 2) AS p25,
  ROUND(APPROX_QUANTILES(tlscertsize, 1000)[OFFSET(500)] / 1024, 2) AS p50,
  ROUND(APPROX_QUANTILES(tlscertsize, 1000)[OFFSET(750)] / 1024, 2) AS p75,
  ROUND(APPROX_QUANTILES(tlscertsize, 1000)[OFFSET(900)] / 1024, 2) AS p90
FROM (
  SELECT
    client,
    _cdn_provider AS cdn,
    LENGTH(JSON_EXTRACT(payload, "$._certificates")) AS tlscertsize
  FROM
    `httparchive.almanac.requests`)
GROUP BY
  client,
  cdn
ORDER BY
  requests DESC