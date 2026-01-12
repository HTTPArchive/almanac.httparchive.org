#standardSQL
# SW objects (2025) — only crawl/custom_metrics updates

CREATE TEMPORARY FUNCTION getSWObjects(swObjectsInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  let values = Object.values(JSON.parse(swObjectsInfo || '{}'));
  if (typeof values !== 'string') values = values.toString();
  return Array.from(new Set(String(values).trim().split(',')));
} catch (e) { return [] }
''';

SELECT
  client,
  sw_object,
  SPLIT(sw_object, '.')[OFFSET(0)] AS object,
  SPLIT(sw_object, '.')[SAFE_OFFSET(1)] AS method,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM `httparchive.crawl.pages`,
  UNNEST(getSWObjects(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.swObjectsInfo')))) AS sw_object
JOIN (
  SELECT client, COUNT(0) AS total
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-06-01' AND is_root_page AND
    JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
  GROUP BY client
) totals USING (client)
WHERE date = DATE '2025-06-01' AND is_root_page AND
  JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true' AND
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.swObjectsInfo')) NOT IN ('[]', '{}', 'null')
GROUP BY client, total, sw_object
ORDER BY freq / total DESC, client;
