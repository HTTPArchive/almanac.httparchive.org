# standardSQL
# Size of 404 status codes by percentile

SELECT
  client,
  status_group,
  status,
  percentile,
  APPROX_QUANTILES(number, 1000)[OFFSET(percentile * 10)] AS number,
  APPROX_QUANTILES(sizeKiB, 1000)[OFFSET(percentile * 10)] AS sizeKiB
FROM
  (
    SELECT
      client,
      LEFT(CAST(status AS STRING), 1) AS status_group,
      status,
      url,
      COUNT(0) AS number,
      SUM(respHeadersSize) / 1024 AS sizeKiB
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2021-07-01' AND
      url LIKE '%favicon.ico'
    GROUP BY
      client,
      status,
      url
  ),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  status_group,
  status,
  percentile
ORDER BY
  client,
  status,
  percentile
