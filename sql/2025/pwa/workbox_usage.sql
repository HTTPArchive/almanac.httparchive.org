#standardSQL
# Workbox usage (2025)

SELECT
  client,
  COUNTIF(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.workboxInfo')) NOT IN ('[]', '{}', 'null')) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNTIF(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.workboxInfo')) NOT IN ('[]', '{}', 'null')) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM `httparchive.crawl.pages`
WHERE
  date = DATE '2025-06-01' AND is_root_page AND
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.manifests')) NOT IN ('[]', '{}', 'null') AND
  JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
GROUP BY client
ORDER BY freq / total DESC, client;
