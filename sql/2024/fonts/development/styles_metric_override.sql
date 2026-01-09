-- Section: Development
-- Question: How and how often is metrics override used in CSS?
-- Normalization: Pages

CREATE TEMPORARY FUNCTION PROPERTIES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const $ = JSON.parse(json);
  const result = [];
  walkDeclarations($, (declaration) => {
    result.push(declaration.property);
  }, {
    properties: ['size-adjust', 'ascent-override', 'descent-override', 'line-gap-override'],
    rules: (rule) => rule.type.toLowerCase() === 'font-face'
  });
  return result;
} catch (e) {
  return [];
}
''';

WITH
properties AS (
  SELECT
    client,
    property,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.parsed_css`,
    UNNEST(PROPERTIES(css)) AS property
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    is_root_page
  GROUP BY
    client,
    property
),

pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    is_root_page
  GROUP BY
    client
)

SELECT
  client,
  property,
  count,
  total,
  count / total AS proportion
FROM
  properties
JOIN
  pages
USING (client)
ORDER BY
  client,
  proportion DESC
