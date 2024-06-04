#standardSQL
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
  COUNT(DISTINCT url) AS pages,
  total_sass,
  COUNT(DISTINCT url) / total_sass AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    mixin
  FROM
    `httparchive.pages.2022_07_01_*`, -- noqa: CV09
    UNNEST(getMixinNames(payload)) AS mixin
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNTIF(SAFE_CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._sass'), '$.scss.size') AS INT64) > 0) AS total_sass
  FROM
    `httparchive.pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  mixin,
  total_sass
ORDER BY
  pct DESC
LIMIT 1000
