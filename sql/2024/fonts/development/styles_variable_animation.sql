-- Section: Development
-- Question: How popular is variable-font animimation in CSS?
-- Normalization: Pages

CREATE TEMPORARY FUNCTION HAS_ANIMATION(json STRING)
RETURNS BOOLEAN
LANGUAGE js
OPTIONS (library = "gs://httparchive/lib/css-utils.js")
AS '''
try {
  const $ = JSON.parse(json);
  let count = 0;
  walkRules($, (rule) => {
    rule.keyframes.forEach((frame) => {
      count += countDeclarations(
        frame,
        {
          properties: [
            'font-stretch',
            'font-style',
            'font-variation-settings',
            'font-weight'
          ]
        }
      );
    });
  }, {
    type: 'keyframes'
  });
  count += countDeclarations($.stylesheet.rules, {
    properties: 'transition',
    values: /font-stretch|font-style|font-variation-settings|font-weight/
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
    date = '2024-07-01' AND -- noqa: CV09
    is_root_page AND
    HAS_ANIMATION(css)
  GROUP BY
    client
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
