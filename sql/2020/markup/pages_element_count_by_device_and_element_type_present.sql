#standardSQL
# how many pages contain an element by element and device M241
# See related: sql/2019/03_Markup/03_02a.sql

CREATE TEMP FUNCTION AS_PERCENT(freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

CREATE TEMPORARY FUNCTION get_element_types(element_count_string STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
    if (!element_count_string) return []; // 2019 had a few cases

    var element_count = JSON.parse(element_count_string); // should be an object with element type properties with values of how often they are present

    if (Array.isArray(element_count)) return [];
    if (typeof element_count != 'object') return [];

    return Object.keys(element_count);
} catch (e) {
    return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  element_type,
  COUNT(DISTINCT url) AS pages,
  total,
  AS_PERCENT(COUNT(DISTINCT url), total) AS pct_m241
FROM
  `httparchive.pages.2020_08_01_*`
JOIN (
  SELECT _TABLE_SUFFIX, COUNT(0) AS total
  FROM
    `httparchive.pages.2020_08_01_*`
  GROUP BY _TABLE_SUFFIX
) # to get an accurate total of pages per device. also seems fast
USING (_TABLE_SUFFIX),
  UNNEST(get_element_types(JSON_EXTRACT_SCALAR(payload, '$._element_count'))) AS element_type
GROUP BY
  client,
  total,
  element_type
ORDER BY
  pages / total DESC,
  client
LIMIT 1000
