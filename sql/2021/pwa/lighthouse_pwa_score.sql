#standardSQL
# Percentiles of lighthouse pwa score
# This metric comes from Lighthouse only and is only available in mobile in HTTP Archive dataset
SELECT
  '2021_07_01' AS date,
  'PWA Sites' AS type,
  percentile,
  APPROX_QUANTILES(score, 1000)[OFFSET(percentile * 10)] * 100 AS score
FROM (
  SELECT
    url,
    CAST(JSON_EXTRACT(report, '$.categories.pwa.score') AS NUMERIC) AS score
  FROM
    `httparchive.lighthouse.2021_07_01_mobile`
)
JOIN (
  SELECT
    url
  FROM
    `httparchive.pages.2021_07_01_mobile`
  WHERE
    JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = 'true' AND
    JSON_EXTRACT(payload, '$._pwa.manifests') != '[]'
)
USING (url),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  date,
  percentile
UNION ALL
SELECT
  '2021_07_01' AS date,
  'All Sites' AS type,
  percentile,
  APPROX_QUANTILES(score, 1000)[OFFSET(percentile * 10)] * 100 AS score
FROM (
  SELECT
    CAST(JSON_EXTRACT(report, '$.categories.pwa.score') AS NUMERIC) AS score
  FROM
    `httparchive.lighthouse.2021_07_01_mobile`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  date,
  percentile
ORDER BY
  date,
  type DESC,
  percentile
