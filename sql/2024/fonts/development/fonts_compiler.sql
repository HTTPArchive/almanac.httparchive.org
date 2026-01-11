-- Section: Development
-- Question: Which compilers are used?
-- Normalization: Fonts (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

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
    COMPILER(JSON_EXTRACT_SCALAR(ANY_VALUE(payload), '$._font_details.names[5]')) AS compiler,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload)
  GROUP BY
    client,
    url
)

SELECT
  client,
  compiler,
  COUNT(DISTINCT url) AS count,
  total,
  COUNT(DISTINCT url) / total AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT url) DESC) AS rank
FROM
  fonts
GROUP BY
  client,
  compiler,
  total
QUALIFY
  rank <= 100
ORDER BY
  client,
  proportion DESC
