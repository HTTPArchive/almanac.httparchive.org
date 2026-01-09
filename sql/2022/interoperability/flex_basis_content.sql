#standardSQL
# Adoption of CSS flex-basis: content
CREATE TEMPORARY FUNCTION getFlexBasisContent(css STRING)
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

    var flexBasisContent = !!rule.declarations.find(
      (d) => d.property == "flex-basis" && d.value.includes("content")
    );

    return values.concat(flexBasisContent);
  };

  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [e];
}
''';

SELECT
  client,
  COUNTIF(sets_flex_basis_content) AS sets_flex_basis_content,
  ANY_VALUE(total_pages) AS total_pages,
  COUNTIF(sets_flex_basis_content) / ANY_VALUE(total_pages) AS pct_sets_flex_basis_content
FROM (
  SELECT
    client,
    page,
    LOGICAL_AND(flex_basis_content) AS sets_flex_basis_content
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getFlexBasisContent(css)) AS flex_basis_content
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
