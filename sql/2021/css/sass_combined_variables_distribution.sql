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
  percentile,
  client,
  usage,
  APPROX_QUANTILES(freq, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS freq
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    var.usage,
    var.freq
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(countCombinedVariables(payload)) AS var
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client,
  usage
ORDER BY
  percentile,
  client,
  usage
