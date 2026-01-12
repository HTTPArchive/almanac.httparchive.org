#standardSQL
# Most popular `content` property values.
# Combines hex values together to reduce duplication (used by icon fonts).
CREATE TEMP FUNCTION getContentStrings(css STRING) RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var reduceValues = (values, rule) => {
    if ('rules' in rule) {
      return rule.rules.reduce(reduceValues, values);
    }
    if (!('declarations' in rule)) {
      return values;
    }
    return values.concat(rule.declarations.filter(d => d.property.toLowerCase() == 'content').map(d => d.value));
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
    IF(
      REGEXP_CONTAINS(content, r'[\'"]\\[ef][0-9a-f]{3}[\'"]'), '"\\f000"-like',
      IF(
        REGEXP_CONTAINS(content, r'[\'"]\\[a-f0-9]{4}[\'"]'), '"\\hex{4}"-like', content
      )
    ) AS content,
    COUNT(DISTINCT page) AS pages,
    total_pages,
    COUNT(DISTINCT page) / total_pages AS pct_pages,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
  FROM (
    SELECT
      client,
      COUNT(DISTINCT page) AS total_pages
    FROM
      `httparchive.almanac.parsed_css`
    WHERE
      date = '2022-07-01' -- noqa: CV09
    GROUP BY
      client
  )
  JOIN
    `httparchive.almanac.parsed_css`
  USING (client),
    UNNEST(getContentStrings(css)) AS content
  WHERE
    date = '2022-07-01' -- noqa: CV09
  GROUP BY
    client,
    content,
    total_pages
)
WHERE
  pages >= 1000
ORDER BY
  pct_pages DESC
LIMIT 200
