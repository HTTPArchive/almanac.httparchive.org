-- Section: Development
-- Question: How popular is variable-font animimation in CSS?

CREATE TEMPORARY FUNCTION HAS_ANIMATION(json STRING)
RETURNS BOOLEAN
LANGUAGE js
OPTIONS(library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  var $ = JSON.parse(json);
  let count = 0;
  walkRules($, rule => {
    rule.keyframes.forEach(f => {
      count += countDeclarations(f, { properties: 'font-variation-settings' });
    });
  }, {
    type: 'keyframes'
  });
  count += countDeclarations($.stylesheet.rules, {
    properties: 'transition',
    values: /font-variation-settings/
  });
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
    date = '2024-07-01'
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
    date = '2024-07-01' AND
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
