#standardSQL

# input attributes occurence defined set % (minus placeholder and required)

CREATE TEMPORARY FUNCTION hasInputAttributes(payload STRING)
RETURNS BOOL LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    var found = almanac['input-elements'].findIndex(node => {
        var search = Object.keys(node).findIndex(attr => {
            if(attr.match(/(autocomplete|min|max|pattern|step)/i)) {
                return true;
            }
        });

        return search >= 0 ? true : false;
    });
    return found >= 0 ? true : false;
  } catch (e) {
    return false;
  }
''';

SELECT
    COUNT(0) as count,
    COUNTIF(hasInputAttributes(payload)) AS occurence,
    ROUND(COUNTIF(hasInputAttributes(payload)) * 100 / SUM(COUNT(0)) OVER (), 2) AS occurence_perc
FROM
    `httparchive.pages.2019_07_01_mobile`
