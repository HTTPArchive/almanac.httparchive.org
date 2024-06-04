# standardSQL
# Number of H2 and H3 Pushed Resources and Bytes by Content type
SELECT
  percentile,
  client,
  type,
  COUNT(DISTINCT page) AS num_pages,
  APPROX_QUANTILES(num_requests, 1000)[OFFSET(percentile * 10)] AS pushed_requests,
  APPROX_QUANTILES(KiB_transfered, 1000)[OFFSET(percentile * 10)] AS KiB_transfered
FROM (
  SELECT
    client,
    page,
    type,
    SUM(respSize / 1024) AS KiB_transfered,
    COUNT(0) AS num_requests
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    pushed = '1' AND (
      LOWER(protocol) = 'http/2' OR
      LOWER(protocol) LIKE '%quic%' OR
      LOWER(protocol) LIKE 'h3%' OR
      LOWER(protocol) = 'http/3'
    )
  GROUP BY
    client,
    page,
    type
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client,
  type
ORDER BY
  percentile,
  client
