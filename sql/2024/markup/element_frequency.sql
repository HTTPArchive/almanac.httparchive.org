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
)

SELECT
  client AS client,
  element_type_info.name,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total) AS pct_pages,
  SUM(element_type_info.freq) AS freq, # total count from all pages
  SUM(SUM(element_type_info.freq)) OVER (PARTITION BY client) AS total_freq,
  SUM(element_type_info.freq) / SUM(SUM(element_type_info.freq)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.all.pages`,
  UNNEST(get_element_types_info(JSON_EXTRACT(custom_metrics, '$.element_count'))) AS element_type_info
JOIN
  totals
USING
  (client)
WHERE
  date = '2024-06-01'
GROUP BY
  client,
  element_type_info.name
ORDER BY
  pct DESC
LIMIT
  1000
