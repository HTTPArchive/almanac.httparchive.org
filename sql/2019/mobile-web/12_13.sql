#standardSQL

# input types occurence prefined set %

CREATE TEMPORARY FUNCTION getInputStats(payload STRING)
RETURNS STRUCT<found_advanced_types BOOLEAN, total_inputs INT64> LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    var found_index = almanac['input-elements'].findIndex(node => {
        if(node.type && node.type.match(/(color|date|datetime-local|email|month|number|range|reset|search|tel|time|url|week|datalist)/i)) {
            return true;
        }
    });

    return {
      found_advanced_types: found_index >= 0 ? true : false,
      total_inputs: almanac['input-elements'].length
    };
  } catch (e) {
    return {
      found_advanced_types: false,
      total_inputs: 0
    };
  }
''';

SELECT
  COUNT(0) AS count,
  COUNTIF(input_stats.total_inputs > 0) AS total_applicable,

  COUNTIF(input_stats.found_advanced_types) AS total_pages_using,
  ROUND(COUNTIF(input_stats.found_advanced_types) * 100 / COUNTIF(input_stats.total_inputs > 0), 2) AS occurence_perc
FROM (
  SELECT
    getInputStats(payload) AS input_stats
  FROM
    `httparchive.pages.2019_07_01_mobile`
)
