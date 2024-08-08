-- Section: Performance
-- Question: Which scripts are popular on the web?

CREATE TEMPORARY FUNCTION SCRIPTS(body STRING)
RETURNS ARRAY<STRING>
LANGUAGE js
OPTIONS (library = ["gs://httparchive/lib/text-utils.js"])
AS r"""
try {
  let codepoints = body
    .replace(/<\/[^>]+(>|$)/g, '')
    .split('')
    .map(c => c.codePointAt(0));
  if (codepoints.length) {
    return detectWritingScript(codepoints, 0.05);
  } else {
    return [];
  }
} catch (e) {
  return [];
}
""";

WITH
scripts AS (
  SELECT
    client,
    script,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`,
    UNNEST(SCRIPTS(response_body)) AS script
  WHERE
    date = '2024-07-01' AND
    type = 'html'
  GROUP BY
    client,
    script
),
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
)

SELECT
  client,
  script,
  count,
  total,
  count / total AS proportion
FROM
  scripts
JOIN
  pages USING (client)
ORDER BY
  client,
  proportion DESC
