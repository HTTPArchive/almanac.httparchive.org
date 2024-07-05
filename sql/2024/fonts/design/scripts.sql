-- Section: Design
-- Question: Which scripts does one design for?

CREATE TEMPORARY FUNCTION SCRIPTS(codepoints ARRAY<STRING>)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/text-utils.js"])
AS r"""
if (codepoints && codepoints.length) {
  return detectWritingScript(codepoints.map(c => parseInt(c, 10)), 0.05);
} else {
  return [];
}
""";

WITH
fonts AS (
  SELECT
    client,
    url,
    ANY_VALUE(payload) AS payload
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    type = 'font'
  GROUP BY
    client,
    url
)

SELECT
  client,
  script,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  fonts,
  UNNEST(SCRIPTS(JSON_EXTRACT_STRING_ARRAY(payload, '$._font_details.cmap.codepoints'))) AS script
GROUP BY
  client,
  script
ORDER BY
  proportion DESC
