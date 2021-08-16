#standardSQL
# SW adoption over time, including ranking
SELECT
  SUBSTRING(yyyymmdd, 0, 4) || '-' || SUBSTRING(yyyymmdd, 5, 2) || '-' || RIGHT(yyyymmdd, 2) AS date,
  client,
  rank_grouping,
  FORMAT("%'d", CAST(rank_grouping AS INT64)) AS ranking,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  (
    SELECT DISTINCT
      FORMAT_DATE('%Y%m%d', yyyymmdd) AS yyyymmdd,
      client,
      url,
      rank
    FROM
      `httparchive.blink_features.features`
    WHERE
      feature = 'ServiceWorkerControlledPage' AND
      yyyymmdd >= '2021-05-01'
  ),
  UNNEST([1000,10000,100000,1000000]) as rank_grouping
JOIN (
  SELECT
    REPLACE(SUBSTR(_TABLE_SUFFIX, 0, 10), '_', '') AS yyyymmdd,
    SUBSTR(_TABLE_SUFFIX, 12) AS client,
    rank_grouping,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.*`,
     UNNEST([1000,10000,100000,1000000]) as rank_grouping
  WHERE
    _TABLE_SUFFIX > '2021_05_01' AND
    rank <= rank_grouping
  GROUP BY
    yyyymmdd,
    rank_grouping,
    client
)
USING
  (yyyymmdd, client, rank_grouping)
JOIN (
  SELECT
    REPLACE(SUBSTR(_TABLE_SUFFIX, 0, 10), '_', '') AS yyyymmdd,
    SUBSTR(_TABLE_SUFFIX, 12) AS client,
    rank,
    url
  FROM
    `httparchive.summary_pages.*`
  WHERE
    _TABLE_SUFFIX > '2021_05_01'
)
USING
  (yyyymmdd, client, url, rank)
WHERE rank <= rank_grouping
GROUP BY
  yyyymmdd,
  client,
  total,
  rank_grouping
UNION ALL
SELECT DISTINCT
  SUBSTRING(yyyymmdd, 0, 4) || '-' || SUBSTRING(yyyymmdd, 5, 2) || '-' || RIGHT(yyyymmdd, 2) AS date,
  client,
  10000000 AS rank_grouping,
  'all' AS ranking,
  num_urls AS freq,
  total_urls AS total,
  num_urls / total_urls AS pct
FROM
  `httparchive.blink_features.usage`
WHERE
  feature = 'ServiceWorkerControlledPage' AND
  yyyymmdd >= '20210501'
ORDER BY
  date DESC,
  pct,
  client
