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
    protocol AS protocol
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    firstHtml)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    _connections
  FROM
    `httparchive.summary_pages.2021_07_01_*`)
USING
  (client, page),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  protocol
ORDER BY
  percentile,
  client,
  protocol
