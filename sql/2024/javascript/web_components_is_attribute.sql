#standardSQL
# pages which use `is` attribute
CREATE TEMPORARY FUNCTION get_almanac_attribute_info(almanac_string STRING)
RETURNS ARRAY<STRUCT<name STRING, freq INT64>> LANGUAGE js AS '''
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return [];

    if (almanac.attributes_used_on_elements) {
      return Object.entries(almanac.attributes_used_on_elements).map(([name, freq]) => ({name, freq}));
    }

} catch (e) {

}
return [];
''';

SELECT
  client,
  COUNTIF(almanac_attribute_info.name = 'is' AND almanac_attribute_info.freq > 0) AS freq,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNTIF(almanac_attribute_info.name = 'is' AND almanac_attribute_info.freq > 0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct_pages
FROM
  `httparchive.all.pages`,
  UNNEST(get_almanac_attribute_info(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS almanac_attribute_info
WHERE
  date = '2024-06-01'
GROUP BY
  client
ORDER BY
  client,
  pct_pages DESC
