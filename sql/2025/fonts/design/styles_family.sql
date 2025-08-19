-- Section: Design
-- Question: Which families are popular in CSS?
-- Normalization: Pages

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

CREATE TEMPORARY FUNCTION FAMILIES(json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/css-font-parser.js", "gs://httparchive/lib/css-utils.js"])
AS '''
try {
  const $ = JSON.parse(json);
  const result = [];
  walkDeclarations($, (declaration) => {
    result.push(parseFontFamilyProperty(declaration.value)[0]);
  }, {
    properties: 'font-family',
    rules: (rule) => rule.type.toLowerCase() === 'font-face'
  });
  return result;
} catch (e) {
  return [];
}
''';

WITH
families AS (
  SELECT
    client,
    FAMILY_INNER(family) AS family,
    COUNT(DISTINCT page) AS count,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS rank
  FROM
    `httparchive.crawl.parsed_css`,
    UNNEST(FAMILIES(TO_JSON_STRING(css))) AS family
  WHERE
    date = @date AND
    is_root_page
  GROUP BY
    client,
    family
  QUALIFY
    rank <= 100
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
  family,
  count,
  total,
  ROUND(count / total, @precision) AS proportion
FROM
  families
JOIN
  pages
USING (client)
ORDER BY
  client,
  count DESC
