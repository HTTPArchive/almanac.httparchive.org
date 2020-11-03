#standardSQL
CREATE TEMPORARY FUNCTION getAnimatedCustomProperties(css STRING) RETURNS
ARRAY<STRING> LANGUAGE js AS '''
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
'''
OPTIONS (library="gs://httparchive/lib/css-utils.js");

SELECT
  client,
  custom_property,
  COUNT(DISTINCT url) AS pages,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getAnimatedCustomProperties(css)) AS custom_property
WHERE
  date = '2020-08-01'
GROUP BY
  client,
  custom_property
ORDER BY
  pct DESC