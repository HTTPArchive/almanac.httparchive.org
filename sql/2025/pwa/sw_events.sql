#standardSQL
# SW events (2025) — only crawl/custom_metrics updates

CREATE TEMPORARY FUNCTION getSWEvents(pwa STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const obj = JSON.parse(pwa || '{}');
  const listeners = Object.values(obj.swEventListenersInfo || {}).flat();
  const props = Object.values(obj.swPropertiesInfo || {}).flat();
  return Array.from(new Set([...(listeners||[]), ...(props||[])]));
} catch (e) { return [] }
''';

SELECT
  client,
  event,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM `httparchive.crawl.pages`,
  UNNEST(getSWEvents(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa')))) AS event
JOIN (
  SELECT client, COUNT(0) AS total
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-06-01' AND is_root_page AND
    JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
  GROUP BY client
) totals USING (client)
WHERE date = DATE '2025-06-01' AND is_root_page AND
  JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
GROUP BY client, total, event
ORDER BY freq / total DESC, client;
