#standardSQL
# Adoption of CSS grid-template-columns: subgrid or grid-template-rows: subgrid
CREATE TEMPORARY FUNCTION getSubgrid(css STRING)
RETURNS ARRAY<BOOL> LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js") AS '''
try {
  var reduceValues = (values, rule) => {
    if ("rules" in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!("declarations" in rule)) {
      return values;
    }

    var subgrid = !!rule.declarations.find(
      (d) => (d.property == "grid-template-columns" || d.property == "grid-template-rows") && d.value.includes("subgrid")
    );

    return values.concat(subgrid);
  };

  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [e];
}
''';

SELECT
  client,
  COUNTIF(sets_subgrid) AS sets_subgrid,
  ANY_VALUE(total_pages) AS total_pages,
  COUNTIF(sets_subgrid) / ANY_VALUE(total_pages) AS pct_sets_subgrid
FROM (
  SELECT
    client,
    page,
    COUNTIF(subgrid) > 0 AS sets_subgrid
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getSubgrid(css)) AS subgrid
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    page
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
