CREATE TEMP FUNCTION getBlendModes(css STRING) RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var blendModes = new Set(['background-blend-mode', 'mix-blend-mode']);
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }
    return values.concat(rule.declarations.filter(d => {
      return blendModes.has(d.property.toLowerCase());
    }).map(d => d.value));
  };
  var $ = JSON.parse(css);
  return $.stylesheet.rules.reduce(reduceValues, []);
} catch (e) {
  return [];
}
''';


WITH blend_modes AS (
  SELECT
    client,
    page,
    blend_mode
  FROM
    `httparchive.almanac.parsed_css`,
    UNNEST(getBlendModes(css)) AS blend_mode
  WHERE
    date = '2022-07-01' -- noqa: CV09
),

totals AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_pages
  FROM
    blend_modes
  GROUP BY
    client
)

SELECT
  *
FROM (
  SELECT
    client,
    blend_mode,
    COUNT(DISTINCT page) AS pages,
    ANY_VALUE(total_pages) AS total,
    COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total_usage,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_usage
  FROM
    totals
  JOIN
    blend_modes
  USING (client)
  GROUP BY
    client,
    blend_mode
)
WHERE
  pct_pages > 0.01
ORDER BY
  freq DESC
