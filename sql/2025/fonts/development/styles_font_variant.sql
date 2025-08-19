-- Section: Development
-- Question: Which features are used via font-variant in CSS?
-- Normalization: Pages

CREATE TEMPORARY FUNCTION PROPERTIES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
function compute(tree) {
  const result = {};
  walkDeclarations(tree, ({ property, value }) => {
    const name = property.toLowerCase();
    if (name === 'font-variant') {
      incrementByKey(result, 'font-variant: ' + value)
    } else if (name.startsWith('font-variant-')) {
      incrementByKey(result, name + ': ' + value);
    }
  });
  return sortObject(result);
}

try {
  const properties = compute(JSON.parse(json));
  return Object.entries(properties).flatMap(([name, count]) => {
    return Array(count).fill(name);
  });
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
    `httparchive.crawl.parsed_css`,
    UNNEST(PROPERTIES(TO_JSON_STRING(css))) AS property
  WHERE
    date = @date AND
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
    `httparchive.crawl.requests`
  WHERE
    date = @date AND
    is_root_page
  GROUP BY
    client
)

SELECT
  client,
  property,
  count,
  total,
  ROUND(count / total, @precision) AS proportion
FROM
  properties
JOIN
  pages
USING (client)
ORDER BY
  client,
  count DESC
