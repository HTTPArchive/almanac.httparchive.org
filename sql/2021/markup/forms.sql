#standardSQL
# pages markup metrics grouped by device and form type

# returns number of forms
CREATE TEMPORARY FUNCTION get_forms_count(markup_string STRING)
RETURNS INT64
LANGUAGE js AS '''
try {
  var markup = JSON.parse(markup_string);

  if (Array.isArray(markup) || typeof markup != 'object') return null;

  return markup.form || 0;
} catch (e) {
  return 0;
}
''';

SELECT
  client,
  forms_count,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_page_with_form
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    get_forms_count(JSON_EXTRACT_SCALAR(payload, '$._element_count')) AS forms_count
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client,
  forms_count
ORDER BY
  client,
  forms_count
