#standardSQL
# SW objects (name only) — 2025

CREATE TEMPORARY FUNCTION getSWObjects(swObjectsInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  let values = Object.values(JSON.parse(swObjectsInfo || '{}'));
  if (typeof values !== 'string') values = values.toString();
  const names = String(values).trim().split(',').map(x => String(x).split('.')[0]);
  return Array.from(new Set(names));
} catch (e) { return [] }
''';

SELECT
  client,
  sw_object,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.crawl.pages`,
  UNNEST(getSWObjects(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.swObjectsInfo')))) AS sw_object
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true'
  GROUP BY
    client
) totals USING (client)
WHERE
  date = '2025-07-01' AND
  is_root_page AND
  JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true' AND
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.swObjectsInfo')) NOT IN ('[]', '{}', 'null')
GROUP BY
  client,
  total,
  sw_object
ORDER BY
  freq / total DESC,
  client;
