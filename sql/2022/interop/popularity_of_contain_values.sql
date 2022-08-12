#standardSQL
# Popularity of CSS contain values
CREATE TEMPORARY FUNCTION getContaine(css STRING)
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

    var contain = rule.declarations.find(
      (d) => d.property == "contain"
    );

    if (!contain) {
      return values;
    }

    return values.concat(contain.value.replace("!important", "").split(" ").filter(Boolean));
  };

  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [e];
}
''';

SELECT
  client,
  contain,
  COUNT(0) AS freq,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(0) / ANY_VALUE(total_pages) AS pct
FROM (
  SELECT
    client,
    page,
    contain
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getContaine(css)) AS contain
  WHERE
    date = '2022-07-01'
  GROUP BY
    client,
    page,
    contain
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
)
USING
  (client)
GROUP BY
  client,
  contain
ORDER BY
  client,
  freq DESC
