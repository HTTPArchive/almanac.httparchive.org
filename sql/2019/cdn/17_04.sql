#standardSQL
# 17_04: Distribution of response header size
SELECT
  client,
  cdn,
  COUNT(0) AS requests,
  APPROX_QUANTILES(resheader, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(resheader, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(resheader, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(resheader, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(resheader, 1000)[OFFSET(900)] AS p90
FROM (
  SELECT
    client,
    CAST(JSON_EXTRACT(payload, '$.response.headersSize') AS INT64) AS resheader,
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
  requests DESC,
  client
