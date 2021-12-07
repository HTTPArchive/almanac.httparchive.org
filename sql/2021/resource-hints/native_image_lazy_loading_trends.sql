#standardSQL
# Trend of pages using native image lazy loading

CREATE TEMPORARY FUNCTION nativeLazyLoads(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac.images.loading_values.length > 0;
} catch (e) {
  return false;
}
''';

WITH pages AS (
  SELECT
    '2019' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.pages.2019_07_01_*`
  UNION ALL
  SELECT
    '2020' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.pages.2020_08_01_*`
  UNION ALL
  SELECT
    '2021' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.pages.2021_07_01_*`
)

SELECT
  year,
  client,
  COUNTIF(nativeLazyLoads(payload)) AS freq,
  COUNT(0) AS total,
  COUNTIF(nativeLazyLoads(payload)) / COUNT(0) AS pct
FROM
  pages
GROUP BY
  year,
  client
ORDER BY
  year,
  client
