#standardSQL
# % of pages having specific custom elements
# See related: sql/2019/03_Markup/03_03c.sql

# 4.9 seconds for sample 10k
# I tried using this to get the total in a shorter way. Could not get it to be accurate, and it was slower!:
# COUNT(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,

CREATE TEMP FUNCTION AS_PERCENT(freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (ROUND(SAFE_DIVIDE(freq, total), 4)
);

CREATE TEMPORARY FUNCTION get_element_types_with_a_dash(element_count_string STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
    if (!element_count_string) return []; // 2019 had a few cases

    var element_count = JSON.parse(element_count_string); // should be an object with element type properties with values of how often they are present

    if (Array.isArray(element_count)) return [];
    if (typeof element_count != 'object') return [];

    var r = Object.keys(element_count).filter(e => e.includes('-')); // array of element type names that include a dash
    if (r.length > 0) return r;

    return []; // could be handy having a row showing how many pages do not have one
} catch (e) {
    return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  element_type_with_a_dash,
  COUNT(DISTINCT url) AS pages,
  total,
  AS_PERCENT(COUNT(DISTINCT url), total) AS pct
FROM
  `httparchive.pages.2020_08_01_*`

JOIN (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM
  `httparchive.pages.2020_08_01_*`
GROUP BY _TABLE_SUFFIX) # to get an accurate total of pages per device. also seems fast
USING (_TABLE_SUFFIX),
  UNNEST(get_element_types_with_a_dash(JSON_EXTRACT_SCALAR(payload, '$._element_count'))) AS element_type_with_a_dash # so we end up with pages + element_type_with_a_dash rows
GROUP BY
  client,
  total,
  element_type_with_a_dash
ORDER BY
  pct DESC,
  client
LIMIT 1000
