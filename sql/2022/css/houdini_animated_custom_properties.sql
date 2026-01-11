#standardSQL
CREATE TEMPORARY FUNCTION getAnimatedCustomProperties(css STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  var ast = JSON.parse(css);
  let ret = new Set();

  walkRules(ast, rule => {
    walkDeclarations(rule.keyframes, ({property, value}) => {
      ret.add(property);
    }, {
      properties: /^--/
    });
  }, {
    type: "keyframes"
  });

  return [...ret];
} catch (e) {
  return [];
}
''';

SELECT DISTINCT
  client,
  custom_property,
  COUNT(DISTINCT page) OVER (PARTITION BY client, custom_property) AS pages,
  COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_pages,
  COUNT(DISTINCT page) OVER (PARTITION BY client, custom_property) / COUNT(DISTINCT page) OVER (PARTITION BY client) AS pct_pages,
  COUNT(0) OVER (PARTITION BY client, custom_property) AS freq,
  COUNT(0) OVER (PARTITION BY client) AS total,
  COUNT(0) OVER (PARTITION BY client, custom_property) / COUNT(0) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getAnimatedCustomProperties(css)) AS custom_property
WHERE
  date = '2022-07-01' -- noqa: CV09
ORDER BY
  pct DESC
