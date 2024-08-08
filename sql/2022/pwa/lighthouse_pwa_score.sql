#standardSQL
# Percentiles of lighthouse pwa score
SELECT
  client,
  '2022_06_01' AS date,
  'PWA Sites' AS type,
  percentile,
  APPROX_QUANTILES(score, 1000)[OFFSET(percentile * 10)] * 100 AS score
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    CAST(JSON_EXTRACT(report, '$.categories.pwa.score') AS NUMERIC) AS score
  FROM
    `httparchive.lighthouse.2022_06_01_*`
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url
  FROM
    `httparchive.pages.2022_06_01_*`
  WHERE
    JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = 'true' AND
    JSON_EXTRACT(payload, '$._pwa.manifests') != '[]' AND JSON_EXTRACT(payload, '$._pwa.manifests') != '{}'
)
USING (client, url),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  client,
  date,
  percentile
UNION ALL
SELECT
  client,
  '2022_06_01' AS date,
  'All Sites' AS type,
  percentile,
  APPROX_QUANTILES(score, 1000)[OFFSET(percentile * 10)] * 100 AS score
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(report, '$.categories.pwa.score') AS NUMERIC) AS score
  FROM
    `httparchive.lighthouse.2022_06_01_*`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  client,
  date,
  percentile
ORDER BY
  client,
  date,
  type,
  percentile
