# standardSQL
# Number and size of status codes by percentile

SELECT
  client,
  status_group,
  status,
  percentile,
  APPROX_QUANTILES(number, 1000)[OFFSET(percentile * 10)] AS number,
  APPROX_QUANTILES(respHeaderSizeKiB, 1000)[OFFSET(percentile * 10)] AS respHeaderSizeKiB,
  APPROX_QUANTILES(respBodySizeKiB, 1000)[OFFSET(percentile * 10)] AS respBodySizeKiB
FROM (
  SELECT
    client,
    LEFT(CAST(status AS STRING), 1) AS status_group,
    status,
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
    status,
    page
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
