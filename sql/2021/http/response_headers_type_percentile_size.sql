# standardSQL
# List of the top used response headers
SELECT
  client,
  header_name AS header,
  percentile,
  COUNT(DISTINCT url) AS URLs,
  APPROX_QUANTILES(header_length, 1000)[OFFSET(percentile * 10)] AS length
FROM (
  SELECT
    client,
    url,
    JSON_EXTRACT_SCALAR(header, '$.name') AS header_name,
    LENGTH(JSON_EXTRACT_SCALAR(header, '$.value')) AS header_length
  FROM
    `httparchive.almanac.requests`,
    UNNEST(JSON_EXTRACT_ARRAY(response_headers)) AS header
  WHERE
    date = '2021-07-01'
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  header,
  percentile
HAVING
  COUNT(DISTINCT url) > 100000
ORDER BY
  client,
  header,
  percentile
