CREATE TEMPORARY FUNCTION get_almanac_attribute_info(almanac_string STRING)
RETURNS ARRAY<STRUCT<name STRING, freq INT64>> LANGUAGE js AS '''
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return [];

    if (almanac.attributes_used_on_elements) {
      return Object.entries(almanac.attributes_used_on_elements).filter(([name, freq]) => name.startsWith('data-')).map(([name, freq]) => ({name, freq}));
    }

} catch (e) {}
return [];
''';

WITH totals AS (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total_pages
  FROM
    `httparchive.pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
),

data_attrs AS (
  SELECT
    _TABLE_SUFFIX AS client,
    almanac_attribute_info.name,
    COUNT(DISTINCT url) AS pages,
    ANY_VALUE(total_pages) AS total_pages,
    COUNT(DISTINCT url) / ANY_VALUE(total_pages) AS pct_pages,
    SUM(almanac_attribute_info.freq) AS freq, # total count from all pages
    SUM(SUM(almanac_attribute_info.freq)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
    SUM(almanac_attribute_info.freq) / SUM(SUM(almanac_attribute_info.freq)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct_ratio
  FROM
    `httparchive.pages.2022_06_01_*`
  JOIN
    totals
  USING (_TABLE_SUFFIX),
    UNNEST(get_almanac_attribute_info(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS almanac_attribute_info
  GROUP BY
    client,
    almanac_attribute_info.name
)

SELECT
  *
FROM
  data_attrs
ORDER BY
  pct_ratio DESC
LIMIT
  1000
