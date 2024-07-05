-- Section: Development
-- Question: How widespread is variable-font animimation in CSS?

CREATE TEMPORARY FUNCTION HAS_ANIMATION(js STRING)
RETURNS BOOLEAN
LANGUAGE js
OPTIONS(library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  var ast = JSON.parse(js);
  let count = 0;

  walkRules(
    ast,
    rule => {
      rule.keyframes.forEach(f => {
        count += countDeclarations(f, { properties: 'font-variation-settings' });
      });
    },
    { type: 'keyframes' }
  );

  count += countDeclarations(
    ast.stylesheet.rules,
    { properties: 'transition', values: /font-variation-settings/ }
  );

  return count > 0;
} catch (e) {
  return false;
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
    date = '2024-06-01'
  GROUP BY
    client
),
properties AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.parsed_css`
  WHERE
    date = '2024-06-01' AND
    HAS_ANIMATION(css)
  GROUP BY
    client
)

SELECT
  client,
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
