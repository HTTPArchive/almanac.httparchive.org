#standardSQL
# % of sites that use @supports.
CREATE TEMPORARY FUNCTION usesSupports(css STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var reduceValues = (value, rule) => {
    return value || rule.type == 'supports';
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, false);
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
    COUNTIF(usesSupports(css)) AS num_stylesheets
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
