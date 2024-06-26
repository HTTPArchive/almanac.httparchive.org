#standardSQL
# Top used elements
# See related: sql/2019/03_Markup/03_02b.sql

CREATE TEMP FUNCTION AS_PERCENT(freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

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
  SUM(element_type_info.freq) AS freq_m201, # total count from all pages
  AS_PERCENT(SUM(element_type_info.freq), SUM(SUM(element_type_info.freq)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_m202
FROM
  `httparchive.pages.2020_08_01_*`,
  UNNEST(get_element_types_info(JSON_EXTRACT_SCALAR(payload, '$._element_count'))) AS element_type_info
GROUP BY
  client,
  element_type_info.name
ORDER BY
  freq_m201 DESC,
  client
LIMIT 1000
