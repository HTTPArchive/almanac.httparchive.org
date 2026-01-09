# Sheet: CSS Ruby
#standardSQL
# Adoption of CSS Ruby
CREATE TEMPORARY FUNCTION usesRuby(css STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    const rubyProperties = new Set(['ruby-position', 'ruby-align', 'ruby-merge', 'ruby-overhang']);
    const rubyDisplayValues = new Set(['ruby', 'ruby-base', 'ruby-text', 'ruby-base-container', 'ruby-text-container']);
    return values.concat(rule.declarations.filter(d => {
      return rubyProperties.has(d.property) || (d.property == 'display' && rubyDisplayValues.has(d.value));
    }));
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []).length > 0;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(uses_ruby) AS freq,
  total,
  COUNTIF(uses_ruby) / total AS pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(usesRuby(css)) > 0 AS uses_ruby
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    page
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  total
