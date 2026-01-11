CREATE TEMPORARY FUNCTION getKeyframes(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = [];

    // Animation names
    walkRules(ast, rule => {
      ret = ret.concat(rule.keyframes.flatMap(k => k.values))
    }, {type: "keyframes"});

    return ret;
  }

  const ast = JSON.parse(css);
  return compute(ast);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  keyframe,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getKeyframes(css)) AS keyframe
WHERE
  date = '2022-07-01' -- noqa: CV09
GROUP BY
  client,
  keyframe
ORDER BY
  pct DESC
LIMIT
  2000
