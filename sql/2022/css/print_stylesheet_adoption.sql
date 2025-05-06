CREATE TEMP FUNCTION hasPrintStylesheet(payload STRING) RETURNS BOOL LANGUAGE js AS r'''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['link-nodes'].nodes.some(link => {
    return link.rel == 'stylesheet' && link.media == 'print';
  });
} catch (e) {
  return false;
}
''';

WITH print AS (
  SELECT
    _TABLE_SUFFIX AS client,
    hasPrintStylesheet(payload) AS has_print_stylesheet
  FROM
    `httparchive.pages.2022_07_01_*` -- noqa: CV09
)

SELECT
  client,
  COUNTIF(has_print_stylesheet) AS pages,
  COUNT(0) AS total,
  COUNTIF(has_print_stylesheet) / COUNT(0) AS pct
FROM
  print
GROUP BY
  client
