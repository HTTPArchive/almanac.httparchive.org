#standardSQL
# Distribution of SW payload sizes - based on 2019/14_03b.sql
SELECT
  date,
  percentile,
  client,
  APPROX_QUANTILES(respSize, 1000)[OFFSET(percentile * 10)] AS bytes
FROM (
  SELECT DISTINCT
    date,
    client,
    page,
    url
  FROM
    `httparchive.almanac.service_workers`
)
JOIN
  `httparchive.almanac.requests`
USING (date, client, page, url),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  date = '2020-08-01'
GROUP BY
  date,
  percentile,
  client
ORDER BY
  date,
  percentile,
  client
