-- Section: Design
-- Question: Which compilers are used?
-- Normalization: Fonts

CREATE TEMPORARY FUNCTION COMPILER(version STRING) AS (
  CASE
    WHEN REGEXP_CONTAINS(version, r'(?i)(Core \d|PS \d|hotconv|makeotf)') THEN 'makeotf'
    WHEN REGEXP_CONTAINS(version, r'(?i)FontCreator') THEN 'FontCreator'
    WHEN REGEXP_CONTAINS(version, r'(?i)Fontself') THEN 'Fontself Maker'
    WHEN REGEXP_CONTAINS(version, r'(?i)(FEAKit|Glyphs)') THEN 'Glyphs.app'
    WHEN REGEXP_CONTAINS(version, r'(?i)gftools') THEN 'fontmake'
    ELSE TRIM(REGEXP_EXTRACT(version, ';(.*)'))
  END
);

WITH
fonts AS (
  SELECT
    client,
    url,
    ANY_VALUE(COMPILER(JSON_EXTRACT_SCALAR(payload, '$._font_details.names[5]'))) AS compiler
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url
)

SELECT
  client,
  compiler,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT url) DESC) AS rank
FROM
  fonts
GROUP BY
  client,
  compiler
QUALIFY
  rank <= 100
ORDER BY
  client,
  proportion DESC
