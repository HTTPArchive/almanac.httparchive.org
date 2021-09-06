# standardSQL
# Number and Size of all responses by percentile

SELECT
  client,
  percentile,
  APPROX_QUANTILES(number, 1000)[OFFSET(percentile * 10)] AS number,
  APPROX_QUANTILES(sizeKiB, 1000)[OFFSET(percentile * 10)] AS sizeKiB
FROM
  (
    SELECT
      client,
      url,
      COUNT(0) AS number,
      SUM(respHeadersSize) / 1024 AS sizeKiB
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2021-07-01'
    GROUP BY
      client,
      url
  ),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
