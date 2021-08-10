#standardSQL

# input attributes occurence defined set % (minus placeholder and required)

CREATE TEMPORARY FUNCTION getInputStats(payload STRING)
RETURNS STRUCT<has_advanced_attributes BOOLEAN, total_inputs INT64> LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    var found_index = almanac['input-elements'].findIndex(node => {
        var search = Object.keys(node).findIndex(attr => {
            if(attr.match(/(autocomplete|min|max|pattern|step)/i)) {
                return true;
            }
        });

        return search >= 0 ? true : false;
    });

    return {
      has_advanced_attributes: found_index >= 0 ? true : false,
      total_inputs: almanac['input-elements'].length
    };
  } catch (e) {
    return {
      has_advanced_attributes: false,
      total_inputs: 0
    };
  }
''';

SELECT
    COUNT(0) AS count,
    COUNTIF(input_stats.total_inputs > 0) AS total_applicable,

    COUNTIF(input_stats.has_advanced_attributes) AS total_pages_using,
    ROUND(COUNTIF(input_stats.has_advanced_attributes) * 100 / COUNTIF(input_stats.total_inputs > 0), 2) AS occurence_perc
FROM (
  SELECT
    getInputStats(payload) AS input_stats
  FROM
    `httparchive.pages.2019_07_01_mobile`
)
