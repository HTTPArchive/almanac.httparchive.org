#standardSQL

# links or buttons only containing an icon

CREATE TEMPORARY FUNCTION hasButtonIconSet(payload STRING)
RETURNS BOOL LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    if(almanac['12.11'] > 0) {
        return true;
    }
    return false;
  } catch (e) {
    return false;
  }
''';

SELECT
  COUNT(url) AS total,
  ROUND(COUNTIF(hasButtonIconSet(payload)) * 100 / COUNT(0), 2) AS pct_has_icon_button
FROM
  `httparchive.pages.2019_07_01_mobile`
