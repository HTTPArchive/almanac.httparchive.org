#standardSQL
# 01_08: Top JS libraries
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
  lib,
  COUNT(0) AS count,
  ROUND(COUNT(0) * 100 / (SELECT COUNT(DISTINCT pageid) FROM `httparchive.summary_pages.2019_07_01_*`), 2) AS pct
FROM (
  SELECT
    url,
    getJSLibs(payload) AS libs
  FROM
    `httparchive.pages.2019_07_01_*`),
  UNNEST(libs) AS lib
GROUP BY
  lib
ORDER BY
  count DESC
LIMIT
  50