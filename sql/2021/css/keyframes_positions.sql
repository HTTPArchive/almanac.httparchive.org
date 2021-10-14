#standardSQL
# Popularity of @keyframes positions
CREATE TEMPORARY FUNCTION getKeyframePositions(css STRING) RETURNS ARRAY<STRING> LANGUAGE js AS r'''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    
    if (rule.type != 'keyframes') {
      return values;
    }
    
    var positions = rule.keyframes.flatMap(keyframe => {
      return keyframe.values;
    });
    return values.concat(positions);
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';

SELECT
  *
FROM (
  SELECT
    client,
    position,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getKeyframePositions(css)) AS position
  WHERE
    date = '2021-07-01'
  GROUP BY
    client,
    position
  ORDER BY
    pct DESC)
LIMIT 500
