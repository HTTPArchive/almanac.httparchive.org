# standardSQL
# Percentiles of sites that main page over HTTP/2 or HTTP/3 by rank
SELECT
  client,
  rank_grouping,
  CASE
    WHEN rank_grouping = 10000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  (
    SELECT
      client,
      page,
      rank
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2021-07-01' AND
      firstHTML AND
      LOWER(protocol) IN ('http/2', 'http/3', 'quic', 'h3-29', 'h3-q050')
  ),
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
JOIN
  (
    SELECT
      client,
      rank_grouping,
      COUNT(0) AS total
    FROM
      `httparchive.almanac.requests`,
      UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
    WHERE
      date = '2021-07-01' AND
      rank <= rank_grouping AND
      firstHTML
    GROUP BY
      client,
      rank_grouping
  )
USING (client, rank_grouping)
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  total,
  rank_grouping
ORDER BY
  client,
  rank_grouping
