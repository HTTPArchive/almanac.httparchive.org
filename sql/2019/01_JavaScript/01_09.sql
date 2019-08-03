#standardSQL
# 01_09: Changes in top JS libraries
CREATE TEMP FUNCTION getJSLibs(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var thirdParties = JSON.parse($['_third-parties']);
    return thirdParties.map(i => i.name);
  } catch (e) {
    return [];
  }
''';

SELECT
  date,
  lib,
  COUNT(0) AS count,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM (
  SELECT
    CAST(REPLACE(SUBSTR(_TABLE_SUFFIX, 0, 10), '_', '-') AS DATE) AS date,
    url,
    getJSLibs(payload) AS libs,
    total
  FROM
    `httparchive.pages.*`
  INNER JOIN (
    SELECT _TABLE_SUFFIX, COUNT(0) AS total
    FROM `httparchive.summary_pages.*`
    GROUP BY _TABLE_SUFFIX)
  USING (_TABLE_SUFFIX)),
  UNNEST(libs) AS lib
GROUP BY
  date,
  lib,
  total
ORDER BY
  date DESC,
  count DESC