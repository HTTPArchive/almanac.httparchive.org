# standardSQL
# Number of HTTP/2 Pushed Resources and distribution of Bytes
SELECT
  percentile,
  client,
  COUNT(DISTINCT page) AS num_pages,
  APPROX_QUANTILES(num_requests, 1000)[OFFSET(percentile * 10)] AS pushed_requests,
  APPROX_QUANTILES(kb_transfered, 1000)[OFFSET(percentile * 10)] AS kb_transfered,
FROM (
 SELECT
    client,
    page,
    SUM(CAST(JSON_EXTRACT_SCALAR(payload, '$._bytesIn') AS INT64) / 1024) AS kb_transfered,
    COUNT(0) AS num_requests
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    JSON_EXTRACT_SCALAR(payload, '$._protocol') = 'HTTP/2' AND
    JSON_EXTRACT_SCALAR(payload, '$._was_pushed') = '1'
  GROUP BY
    client,
    page),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
