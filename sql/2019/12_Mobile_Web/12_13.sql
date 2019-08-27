#standardSQL

# input types occurence prefined set %

CREATE TEMPORARY FUNCTION hasNewInputType(payload STRING)
RETURNS BOOL LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    var found = almanac['input-elements'].findIndex(node => {
        if(node.type && node.type.match(/(color|date|datetime-local|email|month|number|range|reset|search|tel|time|url|week|datalist)/i)) {
            return true;
        }
    });
    return found >= 0 ? true : false;
  } catch (e) {
    return false;
  }
''';

SELECT
    COUNT(0) as count,
    COUNTIF(hasNewInputType(payload)) AS occurence,
    ROUND(COUNTIF(hasNewInputType(payload)) * 100 / SUM(COUNT(0)) OVER (), 2) AS occurence_perc
FROM
    `httparchive.pages.2019_07_01_mobile`
