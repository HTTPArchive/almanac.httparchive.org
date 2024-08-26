#standardSQL
# Distribution of 1P/3P JS bytes
SELECT
  percentile,
  client,
  host,
  APPROX_QUANTILES(kbytes, 1000)[OFFSET(percentile * 10)] AS kbytes
FROM (
  SELECT
    client,
    page,
    IF(NET.HOST(url) IN (
      SELECT domain FROM `httparchive.almanac.third_parties` WHERE date = '2024-06-01' AND category != 'hosting'
    ), 'third party', 'first party') AS host,
    SUM(cast(json_value(payload, '$.response.bodySize') AS INT64)) / 1024 AS kbytes
  FROM
    `httparchive.all.requests`

  WHERE
    date = '2024-06-01' AND
    type = 'script'
  GROUP BY
    client,
    page,
    host),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client,
  host
ORDER BY
  client,
  percentile,
  host
