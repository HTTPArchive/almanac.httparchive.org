#standardSQL
# 07_12: Distribution of TLS negotiation time
SELECT
  client,
  cdn,
  COUNT(0) AS requests,
  APPROX_QUANTILES(tlstime, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(tlstime, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(tlstime, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(tlstime, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(tlstime, 1000)[OFFSET(900)] AS p90
FROM (
  SELECT
    client,
    _cdn_provider AS cdn,
    CAST(JSON_EXTRACT(payload, "$.timings.ssl") AS INT64) AS tlstime
  FROM
    `httparchive.almanac.requests`)
WHERE
  tlstime != -1
GROUP BY
  client,
  cdn
ORDER BY
  requests DESC