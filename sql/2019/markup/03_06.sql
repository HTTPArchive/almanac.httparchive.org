#standardSQL
# 03_06: Elements per page
CREATE TEMPORARY FUNCTION countElements(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var elements = JSON.parse($._element_count);
  if (Array.isArray(elements) || typeof elements != 'object') return null;
  return Object.values(elements).reduce((total, freq) => total + (parseInt(freq, 10) || 0), 0);
} catch (e) {
  return null;
}
''';

SELECT
  percentile,
  client,
  COUNT(DISTINCT url) AS pages,
  APPROX_QUANTILES(elements, 1000)[OFFSET(percentile * 10)] AS elements,
  CAST(ROUND(AVG(elements)) AS INT64) AS avg,
  MIN(elements) AS min,
  MAX(elements) AS max
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    countElements(payload) AS elements
  FROM
    `httparchive.pages.2019_07_01_*`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
