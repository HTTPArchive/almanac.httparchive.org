#standardSQL
CREATE TEMPORARY FUNCTION getCustomFunctionCount(payload STRING) RETURNS INT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var scss = JSON.parse($['_sass']);
  if (!scss.scss) {
    return null;
  }

  return Object.keys(scss.scss.stats.functions).length;
} catch (e) {
  return null;
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(fn, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS sass_custom_functions
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    SUM(getCustomFunctionCount(payload)) AS fn
  FROM
    `httparchive.pages.2020_08_01_*`
  GROUP BY
    client,
    page),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
