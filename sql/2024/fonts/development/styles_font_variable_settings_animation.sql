-- Section: Development
-- Question: How popular is variable-font animimation in CSS?
-- Normalization: Sites

CREATE TEMPORARY FUNCTION HAS_ANIMATION(json STRING)
RETURNS BOOLEAN
LANGUAGE js
OPTIONS(library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const $ = JSON.parse(json);
  let count = 0;
  walkRules($, rule => {
    rule.keyframes.forEach((frame) => {
      count += countDeclarations(frame, { properties: 'font-variation-settings' });
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
properties AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.parsed_css`
  WHERE
    date = '2024-07-01' AND
    is_root_page AND
    HAS_ANIMATION(css)
  GROUP BY
    client
),
sites AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page
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
  sites USING (client)
ORDER BY
  client,
  proportion DESC
