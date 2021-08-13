#standardSQL
# beforeinstallprompt usage

SELECT
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
      JSON_EXTRACT(payload, '$._pwa') != "[]" AND
      JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
      JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true" AND
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa') LIKE '%beforeinstallprompt%'
GROUP BY
  client,
  total
ORDER BY
  freq / total DESC,
  client
