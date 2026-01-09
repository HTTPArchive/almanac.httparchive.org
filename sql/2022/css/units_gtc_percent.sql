#standardSQL
CREATE TEMPORARY FUNCTION doesGTCUsePercent(css STRING)
RETURNS BOOLEAN LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js") AS '''
try {
  var reduceValues = (values, rule) => {
    if ("rules" in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!("declarations" in rule)) {
      return values;
    }

    var declaration = rule.declarations.find(
      (d) => d.property == "grid-template-columns"
    );

    if (!declaration) {
      return values;
    }

    values.push(declaration.value.includes('%'));

    return values;
  };

  var $ = JSON.parse(css);
  return !!$.stylesheet.rules.reduce(reduceValues, []).find(Boolean);
} catch (e) {
  return false;
}
''';

SELECT
  client,
  COUNTIF(uses_percent) AS freq,
  ANY_VALUE(total_pages) AS total_pages,
  COUNTIF(uses_percent) / ANY_VALUE(total_pages) AS pct
FROM (
  SELECT
    client,
    page,
    doesGTCUsePercent(css) AS uses_percent
  FROM
    `httparchive.almanac.parsed_css`
  WHERE
    date = '2022-07-01' -- noqa: CV09
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_07_01_*`  -- noqa: CV09
  GROUP BY
    _TABLE_SUFFIX
)
USING (client)
GROUP BY
  client
