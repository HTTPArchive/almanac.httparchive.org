#standardSQL
# Top used elements

CREATE TEMPORARY FUNCTION get_element_types_info(element_count_string STRING)
RETURNS ARRAY<STRUCT<name STRING, freq INT64>> LANGUAGE js AS '''
try {
    if (!element_count_string) return []; // 2019 had a few cases

    var element_count = JSON.parse(element_count_string); // should be an object with element type properties with values of how often they are present

    if (Array.isArray(element_count) || typeof element_count != 'object') return [];

    return Object.entries(element_count).map(([name, freq]) => ({name, freq}));

} catch (e) {
    return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  element_type_info.name,
  SUM(element_type_info.freq) AS freq, # total count from all pages
  SUM(element_type_info.freq) / SUM(SUM(element_type_info.freq)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(get_element_types_info(JSON_EXTRACT_SCALAR(payload, '$._element_count'))) AS element_type_info
GROUP BY
  client,
  element_type_info.name
ORDER BY
  client,
  freq DESC
LIMIT 1000
