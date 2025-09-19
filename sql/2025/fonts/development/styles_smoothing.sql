-- Section: Development
-- Question: How and how often is smoothing used in CSS?
-- Normalization: Pages

CREATE TEMPORARY FUNCTION PROPERTIES(css JSON)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const result = [];
  walkDeclarations(css, (declaration) => {
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
properties AS (
  SELECT
    client,
    property,
    COUNT(DISTINCT page) AS count,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS rank
  FROM
    `httparchive.crawl.parsed_css`,
    UNNEST(PROPERTIES(css)) AS property
  WHERE
    date = @date AND
    is_root_page
  GROUP BY
    client,
    property
  QUALIFY
    rank <= 10
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
