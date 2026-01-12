#standardSQL
# assetlink usage

SELECT
  'PWA sites' AS type,
  client,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.crawl.pages`
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = DATE '2025-06-01' AND is_root_page AND
    TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.manifests')) NOT IN ('[]', '{}', 'null') AND
    JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true'
  GROUP BY
    client
)
USING (client)
WHERE
  date = DATE '2025-06-01' AND is_root_page AND
  JSON_VALUE(custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true' AND
  TO_JSON_STRING(JSON_QUERY(custom_metrics.other, '$.pwa.manifests')) NOT IN ('[]', '{}', 'null') AND
  JSON_EXTRACT_SCALAR(JSON_QUERY(custom_metrics.well_known, '$'), "$['/.well-known/assetlinks.json'].found") = 'true'
GROUP BY
  client,
  total
UNION ALL
SELECT
  'All sites' AS type,
  client,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.crawl.pages`
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = DATE '2025-06-01' AND is_root_page
  GROUP BY
    client
)
USING (client)
WHERE
  date = DATE '2025-06-01' AND is_root_page AND
  JSON_EXTRACT_SCALAR(JSON_QUERY(custom_metrics.well_known, '$'), "$['/.well-known/assetlinks.json'].found") = 'true'
GROUP BY
  client,
  total
ORDER BY
  type DESC,
  freq / total DESC,
  client
