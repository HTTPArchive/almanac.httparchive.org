#standardSQL
# Popularity of CSS align values
CREATE TEMPORARY FUNCTION getAlign(css STRING)
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

    var align = rule.declarations.find(
      (d) => d.property == "align"
    );

    if (!align) {
      return values;
    }

    values.push(align.value);

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
  align,
  COUNT(0) AS freq,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(0) / ANY_VALUE(total_pages) AS pct
FROM (
  SELECT
    client,
    page,
    align
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getAlign(css)) AS align
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    page,
    align
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
  align
ORDER BY
  client,
  freq DESC
