#standardSQL
CREATE TEMPORARY FUNCTION countCombinedVariables(payload STRING) RETURNS
ARRAY<STRUCT<usage STRING, freq INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var scss = JSON.parse($['_sass']);
  if (!scss.scss) {
    return [];
  }

  return Object.entries(scss.scss.stats.variablesCombined).map(([usage, obj]) => ({usage, freq: Object.keys(obj).length}));
} catch (e) {
  return [];
}
''';

SELECT
  client,
  usage,
  COUNTIF(freq > 0) AS sass_pages_with_combined_variables,
  COUNT(0) AS total_sass_pages,
  total AS total_all_pages,
  COUNTIF(freq > 0) / COUNT(0) AS pct_sass_pages,
  COUNTIF(freq > 0) / total AS pct_all_pages
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    var.usage,
    var.freq
  FROM
    `httparchive.pages.2020_08_01_*`,
    UNNEST(countCombinedVariables(payload)) AS var
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  usage,
  total
