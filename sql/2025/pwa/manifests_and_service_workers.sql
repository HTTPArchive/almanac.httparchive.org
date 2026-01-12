#standardSQL
# Counting Manifests and Service Workers
SELECT
  client,
  SAFE_DIVIDE(SUM(ServiceWorker), SUM(COUNT(0)) OVER (PARTITION BY client)) AS ServiceWorkers,
  SAFE_DIVIDE(SUM(manifests), SUM(COUNT(0)) OVER (PARTITION BY client)) AS Manifests,
  SAFE_DIVIDE(COUNTIF(ServiceWorker > 0 OR manifests > 0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS Either,
  SAFE_DIVIDE(COUNTIF(ServiceWorker > 0 AND manifests > 0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS Both,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total
FROM (
  SELECT
    client,
    IF(JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true', 1, 0) AS ServiceWorker,
    IF(TO_JSON_STRING(custom_metrics.other.pwa.manifests) NOT IN ('[]', '{}', 'null'), 1, 0) AS manifests
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
)
GROUP BY
  client
ORDER BY
  client
