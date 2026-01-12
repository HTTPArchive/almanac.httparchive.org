CREATE TEMP FUNCTION getClipPathFunctions(css STRING) RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }
    return values.concat(rule.declarations.filter(d => {
      return d.property.toLowerCase() == 'clip-path'
    }).map(d => d.value.split('(')[0]));
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';


WITH clip_path_fns AS (
  SELECT
    client,
    page,
    fn
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getClipPathFunctions(css)) AS fn
  WHERE
    date = '2022-07-01' -- noqa: CV09
),

totals AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_pages
  FROM
    clip_path_fns
  GROUP BY
    client
)

SELECT
  *
FROM (
  SELECT
    client,
    fn,
    COUNT(DISTINCT page) AS pages,
    ANY_VALUE(total_pages) AS total,
    COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total_usage,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_usage
  FROM
    totals
  JOIN
    clip_path_fns
  USING (client)
  GROUP BY
    client,
    fn
)
WHERE
  pct_pages > 0.01
ORDER BY
  freq DESC
