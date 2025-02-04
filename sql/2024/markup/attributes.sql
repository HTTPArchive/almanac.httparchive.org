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
    client,
    COUNT(0) AS total
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
),

attributes AS (
  SELECT
    client,
    almanac_attribute_info.name,
    COUNT(DISTINCT page) AS pages,
    ANY_VALUE(total) AS total_pages,
    COUNT(DISTINCT page) / ANY_VALUE(total) AS pct_pages,
    SUM(almanac_attribute_info.freq) AS freq,
    SUM(SUM(almanac_attribute_info.freq)) OVER (PARTITION BY client) AS total,
    SUM(almanac_attribute_info.freq) / SUM(SUM(almanac_attribute_info.freq)) OVER (PARTITION BY client) AS pct_ratio
  FROM
    `httparchive.all.pages`,
    UNNEST(get_almanac_attribute_info(JSON_EXTRACT(custom_metrics, '$.almanac'))) AS almanac_attribute_info
  JOIN
    totals
  USING (client)
  WHERE
    date = '2024-06-01'
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
