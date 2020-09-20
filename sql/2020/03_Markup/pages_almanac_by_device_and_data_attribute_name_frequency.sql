#standardSQL
# pages almanac metrics grouped by device and element data attributes use (frequency)

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

CREATE TEMPORARY FUNCTION get_almanac_attribute_info(almanac_string STRING)
RETURNS ARRAY<STRUCT<name STRING, freq INT64>> LANGUAGE js AS '''
try {
    var almanac = JSON.parse(almanac_string); 

    if (Array.isArray(almanac) || typeof almanac != 'object') return [];

    if (almanac.attributes_used_on_elements) {
      return Object.entries(almanac.attributes_used_on_elements).filter(([name, freq]) => name.startsWith('data-')).map(([name, freq]) => ({name, freq})); 
    }
    
} catch (e) {
    
}
return []; 
''';

SELECT
  _TABLE_SUFFIX AS client,
  almanac_attribute_info.name,
  SUM(almanac_attribute_info.freq) AS freq, # total count from all pages
  AS_PERCENT(SUM(almanac_attribute_info.freq), SUM(SUM(almanac_attribute_info.freq)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_m402 
FROM
  `httparchive.pages.2020_08_01_*`,
  UNNEST(get_almanac_attribute_info(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS almanac_attribute_info
GROUP BY
  client,
  almanac_attribute_info.name
ORDER BY
  freq DESC,
  client
LIMIT
  1000
