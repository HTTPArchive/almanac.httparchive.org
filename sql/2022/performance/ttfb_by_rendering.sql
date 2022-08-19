CREATE TEMPORARY FUNCTION getCSRRatio(payload STRING) RETURNS FLOAT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var stats = JSON.parse($._wpt_bodies);
  return (stats.visible_words.rendered / stats.visible_words.raw) || null;
} catch (e) {
  return null;
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  IF(getCSRRatio(payload) > 1.5, 'CSR', 'SSR') AS rendering,
  COUNT(0) AS pages,
  APPROX_QUANTILES(httparchive.core_web_vitals.GET_CRUX_TTFB(payload), 1000 IGNORE NULLS)[OFFSET(500)] AS median_ttfb
FROM
  `httparchive.pages.2022_06_01_*`
GROUP BY
  client,
  rendering
