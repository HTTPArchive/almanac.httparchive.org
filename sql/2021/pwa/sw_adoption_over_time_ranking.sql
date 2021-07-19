#standardSQL
# SW adoption over time, including ranking
SELECT
  yyyymmdd AS date,
  client,
  CAST(ranking AS STRING) AS rank,
  CASE ranking
    WHEN 1000 THEN '<= 1,000'
    WHEN 10000000 THEN '> 1,000,000'
  ELSE
    FORMAT("%'d", CAST(ranking / 10 + 1 AS INT64)) || ' - ' || FORMAT("%'d", ranking)
  END AS rank_text,
  COUNT(0) AS freq,
  total AS total,
  COUNT(0)/total AS pct
FROM
  `httparchive.blink_features.features`
JOIN (
  SELECT
    REPLACE(SUBSTR(_TABLE_SUFFIX,0,10),'_','') AS yyyymmdd,
    SUBSTR(_TABLE_SUFFIX,12) AS client,
    rank AS ranking,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.*`
  WHERE
    _TABLE_SUFFIX > '2021_05_01'
  GROUP BY
    yyyymmdd,
    client,
    ranking
)
USING
  (yyyymmdd, client)
JOIN (
  SELECT
    REPLACE(SUBSTR(_TABLE_SUFFIX,0,10),'_','') AS yyyymmdd,
    SUBSTR(_TABLE_SUFFIX,12) AS client,
    rank AS ranking,
    url
  FROM
    `httparchive.summary_pages.*`
  WHERE
    _TABLE_SUFFIX > '2021_05_01'
)
USING
  (yyyymmdd, client, url, ranking)
WHERE
  feature = 'ServiceWorkerControlledPage' AND
  yyyymmdd >= '20210501'
GROUP BY
  yyyymmdd,
  client,
  rank,
  rank_text,
  total
UNION ALL
SELECT
  yyyymmdd AS date,
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
