#standardSQL
# Distribution of 1P/3P JS requests
SELECT
  percentile,
  client,
  host,
  APPROX_QUANTILES(requests, 1000)[OFFSET(percentile * 10)] AS num_requests
FROM (
  SELECT
    client,
    page,
    IF(NET.HOST(url) IN (
      SELECT domain FROM `httparchive.almanac.third_parties` WHERE date = '2021-07-01' AND category != 'hosting'
    ), 'third party', 'first party') AS host,
    COUNT(0) AS requests
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    type = 'script'
  GROUP BY
    client,
    page,
    host
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client,
  host
ORDER BY
  percentile,
  client,
  host
