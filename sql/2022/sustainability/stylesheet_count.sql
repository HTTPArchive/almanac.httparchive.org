#standardSQL
# Breakdown of inline vs external stylesheets
CREATE TEMPORARY FUNCTION getStyles(payload STRING)
RETURNS STRUCT<total INT64, inlineStyles INT64, stylesheets INT64>
LANGUAGE js AS
'''
try {
  var $ = JSON.parse(payload);
  var javascript = JSON.parse($._javascript);

  var inlineStyles = javascript.document.inlineStyles;
  var stylesheets = javascript.document.stylesheets;
  var total = inlineStyles + stylesheets;
  return {
    total,
    inlineStyles,
    stylesheets
  };
} catch (e) {
  return {};
}
''';

SELECT
  client,
  SUM(document.total) AS total_stylesheets,
  SUM(document.inlineStyles) AS inline_stylesheets,
  SUM(document.stylesheets) AS external_stylesheets,
  SUM(document.stylesheets) / SUM(document.total) AS pct_external_stylesheets,
  SUM(document.inlineStyles) / SUM(document.total) AS pct_inline_stylesheets,
  APPROX_QUANTILES(SAFE_DIVIDE(document.stylesheets, document.total), 1000)[OFFSET(500)] AS median_external,
  APPROX_QUANTILES(SAFE_DIVIDE(document.inlineStyles, document.total), 1000)[OFFSET(500)] AS median_inline
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getStyles(payload) AS document
  FROM
    `httparchive.pages.2022_06_01_*`
)
GROUP BY
  client
