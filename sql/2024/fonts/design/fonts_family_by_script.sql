-- Section: Design
-- Question: Which families are used broken down by script?

CREATE TEMPORARY FUNCTION NAME(value STRING) AS (
  IF(LENGTH(TRIM(value)) < 3, NULL, NULLIF(TRIM(value), ''))
);

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
  NAME(JSON_EXTRACT_SCALAR(payload, '$._font_details.names[1]')) AS family,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client, script ORDER BY COUNT(0) DESC) AS rank
FROM
  fonts,
  UNNEST(SCRIPTS(JSON_EXTRACT_STRING_ARRAY(payload, '$._font_details.cmap.codepoints'))) AS script
GROUP BY
  client,
  script,
  family
QUALIFY
  rank <= 10
ORDER BY
  client,
  script,
  proportion DESC
