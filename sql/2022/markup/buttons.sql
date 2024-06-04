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
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
)

SELECT
  _TABLE_SUFFIX AS client,
  LOWER(TRIM(button_type)) AS button_type,
  COUNT(DISTINCT url) AS page,
  ANY_VALUE(total) AS total,
  COUNT(DISTINCT url) / ANY_VALUE(total) AS pct_pages
FROM
  `httparchive.pages.2022_06_01_*`
JOIN
  totals
USING (_TABLE_SUFFIX),
  UNNEST(get_markup_buttons_info(JSON_EXTRACT_SCALAR(payload, '$._markup'))) AS button_type
GROUP BY
  client,
  button_type
ORDER BY
  pct_pages DESC
LIMIT
  1000
