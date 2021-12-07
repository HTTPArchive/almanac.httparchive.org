#standardSQL
# SW registration properties
CREATE TEMPORARY FUNCTION getSWRegistrationProperties(swRegistrationPropertiesInfo STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var swRegistrationProperties = Object.values(JSON.parse(swRegistrationPropertiesInfo));
  if (typeof swRegistrationProperties != 'string') {
    swRegistrationProperties = swRegistrationProperties.toString();
  }
  swRegistrationProperties = swRegistrationProperties.trim().split(',').map(x => x.split('.')[0]);
  return Array.from(new Set(swRegistrationProperties));
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  sw_registration_properties,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getSWRegistrationProperties(JSON_EXTRACT(payload, '$._pwa.swRegistrationPropertiesInfo'))) AS sw_registration_properties
JOIN
  (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    WHERE
      JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
    GROUP BY
      _TABLE_SUFFIX
  )
USING (_TABLE_SUFFIX)
WHERE
  JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true" AND
  JSON_EXTRACT(payload, '$._pwa.swRegistrationPropertiesInfo') != "[]"
GROUP BY
  client,
  total,
  sw_registration_properties
ORDER BY
  freq / total DESC,
  client
