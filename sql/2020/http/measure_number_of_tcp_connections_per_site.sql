# standardSQL
# Measure number of TCP Connections per site.
SELECT
  percentile,
  client,
  protocol,
  COUNT(0) AS num_pages,
  APPROX_QUANTILES(_connections, 1000)[OFFSET(percentile * 10)] AS connections
FROM (
  SELECT
    client,
    page,
    JSON_EXTRACT_SCALAR(payload, '$._protocol') AS protocol
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    firstHtml
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    _connections
  FROM
    `httparchive.summary_pages.2020_08_01_*`
)
USING (client, page),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  protocol
ORDER BY
  percentile,
  client,
  protocol
