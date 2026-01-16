CREATE TEMPORARY FUNCTION getKeyframes(css STRING)
RETURNS ARRAY<INT64> LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(ast) {
    let ret = [];

    // Animation names
    walkRules(ast, rule => {
      ret.push(rule.keyframes.length)
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
  percentile,
  client,
  APPROX_QUANTILES(num_keyframes, 1000)[OFFSET(percentile * 10)] AS keyframes_per_animation
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getKeyframes(css)) AS num_keyframes,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2022-07-01' -- noqa: CV09
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
