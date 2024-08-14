-- Section: Development
-- Question: Which features are used via font-variant in CSS?

CREATE TEMPORARY FUNCTION PROPERTIES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  function compute(tree) {
    const result = {};
    walkDeclarations(tree, ({property, value}) => {
      const name = property.toLowerCase();
      if (name === 'font-variant') {
        incrementByKey(result, 'font-variant: ' + value)
      } else if (name.startsWith('font-variant-')) {
        incrementByKey(result, name + ': ' + value);
      }
    });
    return sortObject(result);
  }
  const properties = compute(JSON.parse(json));
  return Object.entries(properties).flatMap(([name, count]) => {
    return Array(count).fill(name);
  });
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
  proportion DESC
