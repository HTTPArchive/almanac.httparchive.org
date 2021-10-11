#standardSQL
# Adoption of @property declarations
CREATE TEMP FUNCTION getAtPropertyValues(css STRING) RETURNS ARRAY<STRUCT<syntax STRING, inherits STRING, `initial-value` STRING>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(css);
  return $.stylesheet.rules.flatMap(rule => {
    if (!rule.selectors) {
      return [];
    }

    var isAtProperty = rule.selectors.filter(selector => {
      return selector.startsWith('@property');
    }).length;

    if (!isAtProperty) {
      return [];
    }

    return Object.fromEntries(rule.declarations.map(declaration => {
      return [declaration.property, declaration.value];
    }));
  });
} catch (e) {
  return [];
}
''';

SELECT
  client,
  syntax,
  inherits,
  initial_value,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    page,
    REGEXP_REPLACE(atproperty.syntax, r'[\'"]', '') AS syntax,
    atproperty.inherits,
    atproperty.`initial-value` AS initial_value
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getAtPropertyValues(css)) AS atproperty
  WHERE
    date = '2021-07-01')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    client)
USING
  (client)
GROUP BY
  client,
  syntax,
  inherits,
  initial_value
