#standardSQL
# SW methods
CREATE TEMPORARY FUNCTION getSWMethods(swMethods ARRAY<STRING>)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  return Array.from(new Set(swMethods));
} catch (e) {
  return [e];
}
''';
CREATE TEMPORARY FUNCTION parseField(field STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
    if(field == '[]' || field == '') {
        return [];
    }

    var parsedField = Object.values(JSON.parse(field));

    if (typeof parsedField != 'string') {
        parsedField = parsedField.toString();
    }

    parsedField = parsedField.trim().split(',');
    return parsedField;
} catch (e) {
  return [e];
}
''';
SELECT
  _TABLE_SUFFIX AS client,
  sw_method,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.sample_data.pages_*`,
  --`httparchive.pages.2021_07_01_*`,
  UNNEST(getSWMethods(parseField(JSON_EXTRACT(payload, '$._pwa.swMethodsInfo')))) AS sw_method
JOIN
  (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
    `httparchive.sample_data.pages_*`
      -- `httparchive.pages.2021_07_01_*`
    WHERE
      JSON_EXTRACT(payload, '$._pwa') != "[]" AND 
      JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa') != "[]" AND
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true" AND
  JSON_EXTRACT(payload, '$._pwa.swMethodsInfo') != "[]"
GROUP BY
  client,
  total,
  sw_method
ORDER BY
  freq / total DESC,
  client