#standardSQL
# assetlink usage

SELECT
  'PWA sites' AS type,
  _TABLE_SUFFIX AS client,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`
JOIN
  (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    WHERE
      JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
      JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true" AND
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
  JSON_EXTRACT_SCALAR(JSON_VALUE(payload, "$._well-known"), "$['/.well-known/assetlinks.json'].found") = 'true'
GROUP BY
  client,
  total
UNION ALL
SELECT
  'All sites' AS type,
  _TABLE_SUFFIX AS client,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`
JOIN
  (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT_SCALAR(JSON_VALUE(payload, "$._well-known"), "$['/.well-known/assetlinks.json'].found") = 'true'
GROUP BY
  client,
  total
ORDER BY
  type DESC,
  freq / total DESC,
  client
