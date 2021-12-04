#standardSQL
CREATE TEMPORARY FUNCTION getMediaQueryProperties(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {};

    walkRules(ast, rule => {
      walkDeclarations(rule.rules, ({property, value}) => {
        incrementByKey(ret, property);
      });
    }, {
      type: "media"
    });

    return sortObject(ret);
  }

  const ast = JSON.parse(css);
  let properties = compute(ast);
  return Object.keys(properties);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  property,
  COUNT(DISTINCT page) AS pages,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM (
  SELECT DISTINCT
    client,
    page,
    LOWER(property) AS property
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN
    UNNEST(getMediaQueryProperties(css)) AS property
  WHERE
    date = '2020-08-01' AND
    property IS NOT NULL)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    client)
USING
  (client)
GROUP BY
  client,
  total,
  property
HAVING
  pct >= 0.01
ORDER BY
  pct DESC
