#standardSQL
# 06_46: % of pages linking to a Google Fonts stylesheet
CREATE TEMP FUNCTION preloadsGoogleFont(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return !!almanac['link-nodes'].find(e => e.rel.toLowerCase() == 'stylesheet' && (e.href.startsWith('https://fonts.googleapis.com') || e.href.startsWith('http://fonts.googleapis.com')));
  } catch (e) {
    return false;
  }

''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(preloadsGoogleFont(payload)) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(preloadsGoogleFont(payload)) * 100 / COUNT(0), 2) AS pct
FROM
  `httparchive.pages.2019_07_01_*`
GROUP BY
  client
