#standardSQL
CREATE TEMPORARY FUNCTION getPageQueryProperties(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = {};

    walkRules(ast, rule => {
      walkDeclarations(rule, ({property, value}) => {
        incrementByKey(ret, property);
      });
    }, {
      type: "page"
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
  COUNT(DISTINCT page) / total AS pct,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_freq
FROM (
  SELECT DISTINCT
    client,
    page,
    LOWER(property) AS property
  FROM
    `httparchive.almanac.parsed_css`
  LEFT JOIN
    UNNEST(getPageQueryProperties(css)) AS property
  WHERE
    date = '2022-07-01' AND -- noqa: CV09
    property IS NOT NULL
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  total,
  property
ORDER BY
  pct DESC
