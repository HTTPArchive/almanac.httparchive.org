#standardSQL
# Most popular custom property values as a percent of pages.
CREATE TEMPORARY FUNCTION getCustomPropertyValues(payload STRING) RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var vars = JSON.parse($['_css-variables']);
  return Object.values(vars.summary);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  value,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    getCustomPropertyValues(payload) AS values,
    total
  FROM
    `httparchive.pages.2020_08_01_*`
  JOIN (
    SELECT
      _TABLE_SUFFIX,
      COUNT(DISTINCT url) AS total
    FROM
      `httparchive.pages.2020_08_01_*`
    GROUP BY
      _TABLE_SUFFIX)
  USING (_TABLE_SUFFIX)),
  UNNEST(values) AS value
GROUP BY
  client,
  value,
  total
ORDER BY
  pct DESC
LIMIT 1000
