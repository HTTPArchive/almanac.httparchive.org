#standardSQL
# SW adoption over time, including ranking
SELECT
  REGEXP_REPLACE(yyyymmdd, r'(\d{4})(\d{2})(\d{2})', r'\1-\2\-3') AS date,
  client,
  rank_grouping,
  CASE
    WHEN rank_grouping = 10000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM (
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
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
JOIN (
  SELECT
    REPLACE(SUBSTR(_TABLE_SUFFIX, 0, 10), '_', '') AS yyyymmdd,
    SUBSTR(_TABLE_SUFFIX, 12) AS client,
    rank_grouping,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    _TABLE_SUFFIX > '2021_05_01' AND
    rank <= rank_grouping
  GROUP BY
    yyyymmdd,
    rank_grouping,
    client
)
USING (yyyymmdd, client, rank_grouping)
WHERE
  rank <= rank_grouping
GROUP BY
  yyyymmdd,
  client,
  total,
  rank_grouping
ORDER BY
  date DESC,
  rank_grouping,
  client
