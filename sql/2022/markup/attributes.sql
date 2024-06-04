#standardSQL
# pages almanac metrics grouped by device and element attribute use (frequency)

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

WITH totals AS (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
),

attributes AS (
  SELECT
    _TABLE_SUFFIX AS client,
    almanac_attribute_info.name,
    COUNT(DISTINCT url) AS pages,
    ANY_VALUE(total) AS total_pages,
    COUNT(DISTINCT url) / ANY_VALUE(total) AS pct_pages,
    SUM(almanac_attribute_info.freq) AS freq,
    SUM(SUM(almanac_attribute_info.freq)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
    SUM(almanac_attribute_info.freq) / SUM(SUM(almanac_attribute_info.freq)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct_ratio
  FROM
    `httparchive.pages.2022_06_01_*`,
    UNNEST(get_almanac_attribute_info(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS almanac_attribute_info
  JOIN
    totals
  USING (_TABLE_SUFFIX)
  GROUP BY
    client,
    almanac_attribute_info.name
)

SELECT
  *
FROM
  attributes
ORDER BY
  pct_ratio DESC
LIMIT
  1000
