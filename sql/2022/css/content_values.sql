#standardSQL
# Popularity of CSS content values
CREATE TEMPORARY FUNCTION getContentValues(css STRING)
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

    var content = rule.declarations.find(
      (d) => d.property == "content"
    );

    if (!content) {
      return values;
    }

    values.push(content.value);

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
  content,
  COUNT(0) AS freq,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(0) / ANY_VALUE(total_pages) AS pct
FROM (
  SELECT
    client,
    page,
    content
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getContentValues(css)) AS content
  WHERE
    date = '2022-07-01'
  GROUP BY
    client,
    page,
    content
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_07_01_*`  --noqa: L062
  GROUP BY
    _TABLE_SUFFIX
)
USING
  (client)
GROUP BY
  client,
  content
ORDER BY
  pct DESC
