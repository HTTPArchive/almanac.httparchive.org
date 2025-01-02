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
    _TABLE_SUFFIX AS client,
    IF(JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = 'true', 1, 0) AS ServiceWorker,
    IF(JSON_EXTRACT(payload, '$._pwa.manifests') != '[]', 1, 0) AS manifests
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
ORDER BY
  client
