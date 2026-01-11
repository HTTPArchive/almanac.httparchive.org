-- Section: Performance
-- Question: What is the usage of font-display in CSS broken down by family?
-- Normalization: Pages

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

CREATE TEMPORARY FUNCTION PROPERTIES(json STRING)
RETURNS ARRAY<STRUCT<family STRING, display STRING>>
LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/css-font-parser.js", "gs://httparchive/lib/css-utils.js"])
AS '''
try {
  const values = ['auto', 'block', 'fallback', 'optional', 'swap'];
  const $ = JSON.parse(json);
  const result = [];
  walkRules($, (rule) => {
    let found = false;
    let family = undefined;
    let display = undefined;
    for (const declaration of rule.declarations) {
      const name = declaration.property.toLowerCase();
      if (name === 'font-family') {
        family = parseFontFamilyProperty(declaration.value)[0];
      }
      if (name === 'font-display') {
        found = true;
        const value = declaration.value.toLowerCase();
        display = values.find((other) => value.includes(other));
      }
      if (family && display) {
        break;
      }
    }
    if (found) {
      result.push({ family, display });
    }
  }, {
    type: 'font-face'
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
    display AS property,
    FAMILY_INNER(family) AS family,
    COUNT(DISTINCT page) AS count,
    ROW_NUMBER() OVER (PARTITION BY client, display ORDER BY COUNT(DISTINCT page) DESC) AS rank
  FROM
    `httparchive.all.parsed_css`,
    UNNEST(PROPERTIES(css)) AS property
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    is_root_page
  GROUP BY
    client,
    property,
    family
  QUALIFY
    rank <= 10
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
  family,
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
  property,
  proportion DESC
