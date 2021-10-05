# standardSQL
# Number and Size of all responses by percentile

SELECT
  client,
  percentile,
  APPROX_QUANTILES(number, 1000)[OFFSET(percentile * 10)] AS responsesCount,
  APPROX_QUANTILES(respHeaderSizeKiB, 1000)[OFFSET(percentile * 10)] AS respHeaderSizeKiB,
  APPROX_QUANTILES(respBodySizeKiB, 1000)[OFFSET(percentile * 10)] AS respBodySizeKiB
FROM
  (
    SELECT
      client,
      page,
      COUNT(0) AS number,
      SUM(respHeadersSize) / 1024 AS respHeaderSizeKiB,
      SUM(respBodySize) / 1024 AS respBodySizeKiB
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2021-07-01'
    GROUP BY
      client,
      page
  ),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
