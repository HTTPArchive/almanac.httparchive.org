#standardSQL
# Usage of advanced input types
# color, date, datetime-local, email, month, number, range, reset, search, tel, time, url, week, datalist
CREATE TEMPORARY FUNCTION getInputStats(payload STRING)
RETURNS STRUCT<found_advanced_types BOOLEAN, total_inputs INT64> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
  const found_index = almanac.input_elements.nodes.findIndex(node => {
    if(node.type && node.type.match(/(color|date|datetime-local|email|month|number|range|reset|search|tel|time|url|week|datalist)/i)) {
      return true;
    }
  });

  return {
    found_advanced_types: found_index >= 0,
    total_inputs: almanac.input_elements.nodes.length,
  };
} catch (e) {
  return {
    found_advanced_types: false,
    total_inputs: 0,
  };
}
''';

SELECT
  COUNT(0) AS total_pages,
  COUNTIF(input_stats.total_inputs > 0) AS total_applicable_pages,
  COUNTIF(input_stats.found_advanced_types) AS total_pages_using,
  COUNTIF(input_stats.found_advanced_types) / COUNTIF(input_stats.total_inputs > 0) AS occurence_pct
FROM (
  SELECT
    getInputStats(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS input_stats
  FROM
    `httparchive.pages.2021_07_01_mobile`
)
