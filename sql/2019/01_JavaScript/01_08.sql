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
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM
  (SELECT COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*`),
  `httparchive.pages.2019_07_01_*`,
  UNNEST(getJSLibs(payload)) AS lib
GROUP BY
  lib,
  total
ORDER BY
  freq DESC