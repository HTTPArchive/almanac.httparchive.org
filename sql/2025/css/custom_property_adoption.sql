#standardSQL
# % of sites that use custom properties.
# Same query as 2019, to compare trend
CREATE TEMPORARY FUNCTION usesCustomProps(css JSON)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }

    return values.concat(rule.declarations.filter(d => d.property.startsWith(`--`)));
  };
  return css.stylesheet.rules.reduce(reduceValues, []).length > 0;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(num_stylesheets > 0) AS freq,
  total,
  COUNTIF(num_stylesheets > 0) / total AS pct
FROM (
  SELECT
    client,
    page,
    COUNTIF(usesCustomProps(css)) AS num_stylesheets
  FROM
    `httparchive.crawl.parsed_css`
  WHERE
    date = '2025-07-01' AND
    rank <= 1000000 AND
    is_root_page -- remove if wanna look at home pages AND inner pages. Old tables only had home pages.
  GROUP BY
    client,
    page
)
JOIN (
  SELECT
    client,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    rank <= 1000000 AND
    is_root_page -- remove if wanna look at home pages AND inner pages. Old tables only had home pages.
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  total
