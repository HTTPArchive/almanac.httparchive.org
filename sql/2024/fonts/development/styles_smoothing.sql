-- Section: Development
-- Question: How and how often is smoothing used in CSS?
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
    result.push(`${declaration.property}: ${declaration.value}`);
  }, {
    properties: ['-webkit-font-smoothing', '-moz-osx-font-smoothing', 'font-smooth']
  });
  return result;
} catch (e) {
  return [];
}
''';

WITH
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01'
  GROUP BY
    client
),
properties AS (
  SELECT
    client,
    property,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.parsed_css`,
    UNNEST(PROPERTIES(css)) AS property
  WHERE
    date = '2024-07-01'
  GROUP BY
    client,
    property
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
  pages USING (client)
ORDER BY
  client,
  proportion DESC
