# standardSQL
# Measure number of TCP Connections per site.
SELECT
  percentile,
  client,
  http_version_category,
  COUNT(0) AS num_pages,
  APPROX_QUANTILES(_connections, 1000)[OFFSET(percentile * 10)] AS connections
FROM (
  SELECT
    client,
    page,
    CASE
      WHEN LOWER(protocol) = 'quic' OR LOWER(protocol) LIKE 'h3%' THEN 'HTTP/2+'
      WHEN LOWER(protocol) = 'http/2' OR LOWER(protocol) = 'http/3' THEN 'HTTP/2+'
      WHEN protocol IS NULL THEN 'Unknown'
      ELSE UPPER(protocol)
    END AS http_version_category
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    firstHtml
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    _connections
  FROM
    `httparchive.summary_pages.2021_07_01_*`
)
USING (client, page),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  http_version_category
ORDER BY
  percentile,
  client,
  num_pages DESC,
  http_version_category
