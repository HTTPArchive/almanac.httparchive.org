#standardSQL
# Percentiles of lighthouse pwa score

-- PWA Sites
SELECT
  client,
  DATE '2025-05-01' AS date,
  'PWA Sites' AS type,
  percentile,
  APPROX_QUANTILES(score, 1000)[OFFSET(percentile * 10)] * 100 AS score
FROM (
  SELECT
    p.client,
    p.page,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.pwa.score') AS NUMERIC) AS score
  FROM
    `httparchive.crawl.pages` p
  WHERE
    p.date = DATE '2025-05-01'
    AND p.is_root_page
    AND JSON_VALUE(p.custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
    AND TO_JSON_STRING(JSON_QUERY(p.custom_metrics.other, '$.pwa.manifests')) NOT IN ('[]','{}','null')
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  client,
  date,
  percentile

UNION ALL

-- All Sites
SELECT
  client,
  DATE '2025-05-01' AS date,
  'All Sites' AS type,
  percentile,
  APPROX_QUANTILES(score, 1000)[OFFSET(percentile * 10)] * 100 AS score
FROM (
  SELECT
    p.client,
    CAST(JSON_VALUE(p.lighthouse, '$.categories.pwa.score') AS NUMERIC) AS score
  FROM
    `httparchive.crawl.pages` p
  WHERE
    p.date = DATE '2025-05-01'
    AND p.is_root_page
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

