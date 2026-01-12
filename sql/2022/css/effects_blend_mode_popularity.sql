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
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_07_01_*` -- noqa: CV09
  GROUP BY
    client
)

SELECT
  client,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total_pages) AS total,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct
FROM
  totals
JOIN
  blend_modes
USING (client)
GROUP BY
  client
