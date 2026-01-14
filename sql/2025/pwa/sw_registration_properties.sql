#standardSQL
# SW registration properties (2025)

CREATE TEMPORARY FUNCTION getSWRegistrationProperties(info STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  let vals = Object.values(JSON.parse(info || '{}'));
  if (typeof vals !== 'string') vals = vals.toString();
  return Array.from(new Set(String(vals).trim().split(',')));
} catch (e) { return [] }
''';

SELECT
  client,
  sw_registration_properties,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.crawl.pages`,
  UNNEST(getSWRegistrationProperties(TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.swRegistrationPropertiesInfo')))) AS sw_registration_properties
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
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.swRegistrationPropertiesInfo')) NOT IN ('[]', '{}', 'null')
GROUP BY
  client,
  total,
  sw_registration_properties
ORDER BY
  freq / total DESC,
  client;
