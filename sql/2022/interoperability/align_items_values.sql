#standardSQL
# Popularity of CSS align values
CREATE TEMPORARY FUNCTION getAlignItems(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js") AS '''
try {
  var reduceValues = (values, rule) => {
    if ("rules" in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!("declarations" in rule)) {
      return values;
    }

    var alignItems = rule.declarations.find(
      (d) => d.property == "align-items"
    );

    if (!alignItems) {
      return values;
    }

    values.push(alignItems.value);

    return values;
  };

  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  alignItems,
  COUNT(0) AS freq,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(0) / ANY_VALUE(total_pages) AS pct
FROM (
  SELECT
    client,
    page,
    alignItems
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getAlignItems(css)) AS alignItems
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    page,
    alignItems
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
  client,
  alignItems
ORDER BY
  pct DESC
