#standardSQL
# Adoption of CSS transform-style: preserve-3d
CREATE TEMPORARY FUNCTION getTransformStylePreserve3d(css STRING)
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

    var transformStylePreserve3d = !!rule.declarations.find(
      (d) => d.property == "transform-style" && d.value.includes("preserve-3d")
    );

    return values.concat(transformStylePreserve3d);
  };

  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [e];
}
''';

SELECT
  client,
  COUNTIF(sets_transform_style_preserve_3d) AS sets_transform_style_preserve_3d,
  ANY_VALUE(total_pages) AS total_pages,
  COUNTIF(sets_transform_style_preserve_3d) / ANY_VALUE(total_pages) AS pct_sets_transform_style_preserve_3d
FROM (
  SELECT
    client,
    page,
    COUNTIF(transform_style_preserve_3d) > 0 AS sets_transform_style_preserve_3d
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getTransformStylePreserve3d(css)) AS transform_style_preserve_3d
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
