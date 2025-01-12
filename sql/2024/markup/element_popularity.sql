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
  element_type,
  COUNT(DISTINCT page) AS pages,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.all.pages`
JOIN
  totals
USING (client),
  UNNEST(get_element_types(JSON_EXTRACT(custom_metrics, '$.element_count'))) AS element_type
WHERE
  date = '2024-06-01'
GROUP BY
  client,
  total,
  element_type
ORDER BY
  pct DESC,
  client,
  pages DESC
LIMIT 1000
