# standardSQL
# Number of H2 and H3 Pushed Resources and Bytes by Content type
SELECT
  percentile,
  client,
  http_version,
  type,
  COUNT(DISTINCT page) AS num_pages,
  APPROX_QUANTILES(num_requests, 1000)[OFFSET(percentile * 10)] AS pushed_requests,
  APPROX_QUANTILES(kb_transfered, 1000)[OFFSET(percentile * 10)] AS kb_transfered
FROM (
  SELECT
    client,
    page,
    JSON_EXTRACT_SCALAR(payload, '$._protocol') AS http_version,
    type,
    SUM(CAST(JSON_EXTRACT_SCALAR(payload, "$._bytesIn") AS INT64) / 1024) AS kb_transfered,
    COUNT(0) AS num_requests
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    JSON_EXTRACT_SCALAR(payload, "$._was_pushed") = "1" AND
    (LOWER(JSON_EXTRACT_SCALAR(payload, "$._protocol")) LIKE "http/2" OR
                               LOWER(JSON_EXTRACT_SCALAR(payload, "$._protocol")) LIKE "%quic%" OR
      LOWER(JSON_EXTRACT_SCALAR(payload, "$._protocol")) LIKE "h3%" OR
      LOWER(JSON_EXTRACT_SCALAR(payload, "$._protocol")) LIKE "http/3%")
  GROUP BY
    client,
    http_version,
    page,
    type),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  http_version,
  type
ORDER BY
  percentile,
  client
