#standardSQL
# Top most used display values in manifest files
# Question: Below only uses first manifest - what should we do it more than one is defined?

CREATE TEMP FUNCTION getDisplay(manifest STRING) RETURNS STRING LANGUAGE js AS '''
try {
  var $ = Object.values(JSON.parse(manifest))[0];
  if (!('display' in $)) {
    return '(not set)';
  }
  return $.display;
} catch {
  return '(not set)'
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  getDisplay(JSON_EXTRACT(payload, '$._pwa.manifests')) AS display,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.sample_data.pages_*`
--`httparchive.pages.2021_07_01_*`
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.manifests') != "[]"
GROUP BY
  client,
  display
ORDER BY
  freq / total DESC,
  display,
  client
