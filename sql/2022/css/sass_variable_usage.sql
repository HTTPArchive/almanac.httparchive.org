#standardSQL
CREATE TEMPORARY FUNCTION getVariableUsage(payload STRING) RETURNS
ARRAY<STRUCT<variable STRING, freq INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var scss = JSON.parse($['_sass']);
  if (!scss.scss) {
    return [];
  }

  return Object.entries(scss.scss.stats.variables).map(([variable, freq]) => {
    return {variable, freq};
  });
} catch (e) {
  return [];
}
''';

SELECT
  client,
  variable,
  COUNT(DISTINCT page) AS pages,
  total_sass,
  COUNT(DISTINCT page) / total_sass AS pct_sass_pages,
  SUM(freq) AS freq,
  SUM(SUM(freq)) OVER (PARTITION BY client) AS total,
  SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    variable.variable,
    variable.freq
  FROM
    `httparchive.pages.2022_07_01_*`, -- noqa: CV09
    UNNEST(getVariableUsage(payload)) AS variable
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS total_sass
  FROM
    `httparchive.pages.2022_07_01_*`, -- noqa: CV09
    UNNEST(getVariableUsage(payload))
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  variable,
  total_sass
ORDER BY
  pct DESC
LIMIT 500
