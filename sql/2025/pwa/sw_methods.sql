#standardSQL
# SW methods (2025) — only crawl/custom_metrics updates

CREATE TEMPORARY FUNCTION getSWMethods(swMethodsInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const info = JSON.parse(swMethodsInfo || '{}');
  return Array.from(new Set(Object.values(info || {}).flat()));
} catch (e) { return [] }
''';

SELECT
  client,
  sw_method,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM `httparchive.crawl.pages`,
  UNNEST(getSWMethods(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.swMethodsInfo')))) AS sw_method
JOIN (
  SELECT client, COUNT(0) AS total
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-06-01' AND is_root_page AND
    JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
  GROUP BY client
) totals USING (client)
WHERE date = DATE '2025-06-01' AND is_root_page AND
  JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true' AND
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.swMethodsInfo')) NOT IN ('[]', '{}', 'null')
GROUP BY client, total, sw_method
ORDER BY freq / total DESC, client;
