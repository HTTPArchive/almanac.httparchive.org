#standardSQL
# Adoption of CSS transform: perspective(none)
CREATE TEMPORARY FUNCTION getTransformPerspectiveNone(css STRING)
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

    var transformPerspectiveNone = !!rule.declarations.find(
      (d) => d.property == "perspective" && d.value.includes("none")
    );

    return values.concat(transformPerspectiveNone);
  };

  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [e];
}
''';

SELECT
  client,
  COUNTIF(sets_transform_perspective_none) AS sets_transform_perspective_none,
  ANY_VALUE(total_pages) AS total_pages,
  COUNTIF(sets_transform_perspective_none) / ANY_VALUE(total_pages) AS pct_sets_transform_perspective_none
FROM (
  SELECT
    client,
    page,
    COUNTIF(transform_perspective_none) > 0 AS sets_transform_perspective_none
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getTransformPerspectiveNone(css)) AS transform_perspective_none
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
