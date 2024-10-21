#standardSQL
# 10_07c: <meta description> length
CREATE TEMP FUNCTION getMetaDescriptionLength(payload STRING)
RETURNS INT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  var description = almanac['meta-nodes'].find(meta => meta.name.toLowerCase() == 'description');
  return description && description.content.length;
} catch (e) {
  return null;
}
''';

SELECT
  percentile,
  client,
  APPROX_QUANTILES(description_length, 1000)[OFFSET(percentile * 10)] AS desc_length
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getMetaDescriptionLength(payload) AS description_length
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
