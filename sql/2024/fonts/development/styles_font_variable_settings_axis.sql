-- Section: Development
-- Question: Which axes are used in CSS?
-- Normalization: Pages (variable only)

CREATE TEMPORARY FUNCTION PROPERTIES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
AS '''
function compute(values, rule) {
  if ('rules' in rule) {
    return rule.rules.reduce(compute, values);
  }
  if (!('declarations' in rule)) {
    return values;
  }
  return values.concat(
    rule.declarations
      .filter((declaration) => declaration.property.toLowerCase() === 'font-variation-settings')
      .map((declaration) => declaration.value)
  );
}

try {
  const $ = JSON.parse(json);
  return $.stylesheet.rules.reduce(compute, []);
} catch (e) {
  return [];
}
''';

WITH
pages AS (
  SELECT
    client,
    page,
    REGEXP_EXTRACT(chunk, r'''['"]([\w]{4})['"]''') AS axis,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.parsed_css`,
    UNNEST(PROPERTIES(css)) AS property,
    UNNEST(SPLIT(property, ',')) AS chunk
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    is_root_page
  GROUP BY
    client,
    page,
    axis
  HAVING
    axis IS NOT NULL
)

SELECT
  client,
  axis,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion
FROM
  pages
GROUP BY
  client,
  axis,
  total
ORDER BY
  client,
  proportion DESC
