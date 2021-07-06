#standardSQL
# beforeinstallprompt usage

SELECT
  _TABLE_SUFFIX client,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0)/SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.sample_data.pages_*`
  --`httparchive.pages.2021_06_01_*`
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa') like '%beforeinstallprompt%'
GROUP BY
  client
ORDER BY
  freq/total DESC,
  client
