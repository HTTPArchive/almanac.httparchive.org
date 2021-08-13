#standardSQL
# SW adoption over time, including ranking
SELECT
  SUBSTRING(yyyymmdd, 0, 4) || '-' || SUBSTRING(yyyymmdd, 5, 2) || '-' || RIGHT(yyyymmdd, 2) AS date,
  client,
  CAST(rank AS STRING) AS rank,
  CASE rank
    WHEN 1000 THEN '<= 1,000'
    WHEN 10000000 THEN '> 1,000,000'
    ELSE
      FORMAT("%'d", CAST(rank / 10 + 1 AS INT64)) || ' - ' || FORMAT("%'d", rank)
  END AS rank_text,
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
  )
JOIN (
  SELECT
    REPLACE(SUBSTR(_TABLE_SUFFIX, 0, 10), '_', '') AS yyyymmdd,
    SUBSTR(_TABLE_SUFFIX, 12) AS client,
    rank,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.*`
  WHERE
    _TABLE_SUFFIX > '2021_05_01'
  GROUP BY
    yyyymmdd,
    client,
    rank
)
USING
  (yyyymmdd, client, rank)
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
GROUP BY
  yyyymmdd,
  client,
  rank,
  rank_text,
  total
UNION ALL
SELECT DISTINCT
  SUBSTRING(yyyymmdd, 0, 4) || '-' || SUBSTRING(yyyymmdd, 5, 2) || '-' || RIGHT(yyyymmdd, 2) AS date,
  client,
  'all' AS rank,
  'all' AS rank_text,
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
  rank,
  client
