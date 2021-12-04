#standardSQL
# 02_15: Top snap points in media queries
CREATE TEMPORARY FUNCTION getSnapPoints(css STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if (rule.type != 'media') {
      return values;
    }

    return values.concat(rule.media.split(',').filter(query => {
      return query.match(/(min|max)-(width|height)/i) && query.match(/\\d+\\w*/);
    }).map(query => {
      return query.match(/\\d+\\w*/)[0]
    }));
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  snap_point,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.parsed_css`,
  UNNEST(getSnapPoints(css)) AS snap_point
WHERE
  date = '2019-07-01'
GROUP BY
  client,
  snap_point
ORDER BY
  freq / total DESC
LIMIT 1000
