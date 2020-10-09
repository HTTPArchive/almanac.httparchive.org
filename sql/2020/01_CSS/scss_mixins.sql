#standardSQL
# Most popular mixin names as a percent of pages
CREATE TEMPORARY FUNCTION getMixinNames(payload STRING) RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var scss = JSON.parse($['_sass']);
  if (!scss.scss) {
    return [];
  }

  return Object.keys(scss.scss.stats.mixins);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  mixin,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    mixin,
    total
  FROM
    `httparchive.pages.2020_08_01_*`,
    UNNEST(getMixinNames(payload)) AS mixin)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS total
  FROM
    `httparchive.pages.2020_08_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (client)
GROUP BY
  client,
  mixin,
  total
ORDER BY
  pct DESC
LIMIT
  1000
