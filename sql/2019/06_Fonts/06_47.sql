#standardSQL
# 06_47: % of pages linking to a Google Fonts stylesheet as first item in <head>
CREATE TEMP FUNCTION preloadsGoogleFontFirst(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return !!almanac['06.47'] == 1;
  } catch (e) {
    return false;
  }

''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(preloadsGoogleFontFirst(payload)) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(preloadsGoogleFontFirst(payload)) * 100 / COUNT(0), 2) AS pct
FROM
  `httparchive.pages.2019_07_01_*`
GROUP BY
  client