#standardSQL
# SW registration properties
CREATE TEMPORARY FUNCTION getSWRegistrationProperties(swRegistrationPropertiesInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var swRegistrationProperties = Object.values(JSON.parse(swRegistrationPropertiesInfo));
  if (typeof swRegistrationProperties != 'string') {
    swRegistrationProperties = swRegistrationProperties.toString();
  }
  swRegistrationProperties = swRegistrationProperties.trim().split(',');
  return Array.from(new Set(swRegistrationProperties));
} catch (e) {
  return [e];
}
''';
SELECT
 _TABLE_SUFFIX AS client,
  sw_object,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.sample_data.pages_*`,
  --`httparchive.pages.2021_07_01_*`,
  UNNEST(getSWRegistrationProperties(JSON_EXTRACT(payload, '$._pwa.swRegistrationPropertiesInfo'))) AS sw_registration_properties
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
  JSON_EXTRACT(payload, '$._pwa.swRegistrationPropertiesInfo') != "[]"
GROUP BY
  client,
  total,
  sw_registration_properties
ORDER BY
  freq / total DESC,
  client