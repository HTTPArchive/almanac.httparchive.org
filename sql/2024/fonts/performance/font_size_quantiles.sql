WITH
urls AS (
  SELECT
    url,
    client,
    AVG(PARSE_NUMERIC(header.value)) AS size
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS header
  WHERE
    date = '2024-06-01' AND
    type = 'font' AND
    LOWER(header.name) = 'content-length' AND
    TRIM(header.value) != ''
  GROUP BY
    url,
    client
)

SELECT
  client,
  percentile,
  COUNT(DISTINCT url) AS count,
  APPROX_QUANTILES(size, 1000)[OFFSET(percentile * 10)] AS size
FROM
  urls,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
