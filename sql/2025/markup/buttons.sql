CREATE TEMPORARY FUNCTION get_markup_buttons_info(markup_buttons JSON)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
if (markup_buttons === '' || markup_buttons == null || markup_buttons.types == null) {
  return [];
}
var type_total = Object.values(markup_buttons.types).reduce((total, i) => total + i, 0);
var types = [];
if (markup_buttons.total > type_total) {
  types = ['NO_TYPE'];
}
return Object.keys(markup_buttons.types).concat(types);
''';

WITH totals AS (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
  GROUP BY
    client
)

SELECT
  client AS client,
  LOWER(TRIM(button_type)) AS button_type,
  COUNT(DISTINCT page) AS page,
  ANY_VALUE(total) AS total,
  COUNT(DISTINCT page) / ANY_VALUE(total) AS pct_pages
FROM
  `httparchive.crawl.pages`
JOIN
  totals
USING (client),
  UNNEST(get_markup_buttons_info(custom_metrics.markup.buttons)) AS button_type
WHERE
  date = '2025-07-01' AND
  custom_metrics.markup.buttons IS NOT NULL
GROUP BY
  client,
  button_type
ORDER BY
  pct_pages DESC
LIMIT
  1000
