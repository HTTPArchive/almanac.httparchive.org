CREATE TEMPORARY FUNCTION get_markup_buttons_info(markup_string STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
    var markup = JSON.parse(markup_string);
    var type_total = Object.values(markup.buttons.types).reduce((total, i) => total + i, 0);
    var types = [];
    if (markup.buttons.total > type_total) {
      types = ['NO_TYPE'];
    }
    return Object.keys(markup.buttons.types).concat(types);
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
  LOWER(TRIM(button_type)) AS button_type,
  COUNT(DISTINCT page) AS page,
  ANY_VALUE(total) AS total,
  COUNT(DISTINCT page) / ANY_VALUE(total) AS pct_pages
FROM
  `httparchive.all.pages`
JOIN
  totals
USING
  (client),
  UNNEST(get_markup_buttons_info(JSON_EXTRACT(custom_metrics, '$.markup'))) AS button_type
WHERE
  date = '2024-06-01'
GROUP BY
  client,
  button_type
ORDER BY
  pct_pages DESC
LIMIT
  1000
