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
  lib,
  freq_2018,
  ROUND(pct_2018 * 100, 2) AS pct_2018,
  freq_2019,
  ROUND(pct_2019 * 100, 2) AS pct_2019,
  ROUND((pct_2019 - pct_2018) * 100, 2) AS pct_pt_change,
  IF(pct_2018 > 0, ROUND((pct_2019 - pct_2018) * 100 / pct_2018, 2), NULL) AS pct_change
FROM (
  SELECT
    lib,
    COUNT(0) AS freq_2018,
    COUNT(0) / total AS pct_2018
  FROM
    (SELECT COUNT(0) AS total FROM `httparchive.summary_pages.2018_07_01_*`),
    `httparchive.pages.2018_07_01_*`,
    UNNEST(getJSLibs(payload)) AS lib
  GROUP BY
    lib,
    total)
JOIN (
  SELECT
    lib,
    COUNT(0) AS freq_2019,
    COUNT(0) / total AS pct_2019
  FROM
    (SELECT COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*`),
    `httparchive.pages.2019_07_01_*`,
    UNNEST(getJSLibs(payload)) AS lib
  GROUP BY
    lib,
    total)
USING (lib)
ORDER BY
  freq_2019 DESC