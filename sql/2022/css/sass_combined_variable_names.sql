#standardSQL
CREATE TEMPORARY FUNCTION getCombinedVariableNames(payload STRING) RETURNS
ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var scss = JSON.parse($['_sass']);
  if (!scss.scss) {
    return [];
  }

  return Object.keys(scss.scss.stats.variablesCombined.name);
} catch (e) {
  return [];
}
''';

SELECT
  *
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    name,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
  FROM
    `httparchive.pages.2022_07_01_*`, -- noqa: CV09
    UNNEST(getCombinedVariableNames(payload)) AS name
  GROUP BY
    client,
    name
)
ORDER BY
  pct DESC
LIMIT 100
