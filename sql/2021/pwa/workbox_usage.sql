#standardSQL
# Workbox usage

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(JSON_EXTRACT(payload, '$._pwa.workboxInfo') != "[]") AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNTIF(JSON_EXTRACT(payload, '$._pwa.workboxInfo') != "[]") / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2021_07_01_*`
WHERE
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
GROUP BY
  client
ORDER BY
  freq / total DESC,
  client
