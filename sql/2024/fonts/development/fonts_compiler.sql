-- Section: Design
-- Question: Which compilers are used?

CREATE TEMPORARY FUNCTION COMPILER(version STRING) AS (
  CASE
    WHEN REGEXP_CONTAINS(version, r'(?i)(Core \d|PS \d|hotconv|makeotf)') THEN 'Adobe Font Development Kit for OpenType'
    WHEN REGEXP_CONTAINS(version, r'(?i)FontCreator') THEN 'FontCreator'
    WHEN REGEXP_CONTAINS(version, r'(?i)Fontself') THEN 'Fontself Maker'
    WHEN REGEXP_CONTAINS(version, r'(?i)ttfautohint') THEN 'FreeType'
    WHEN REGEXP_CONTAINS(version, r'(?i)(FEAKit|Glyphs)') THEN 'Glyphs.app'
    WHEN REGEXP_CONTAINS(version, r'(?i)gftools') THEN 'Google Fonts Tools'
    ELSE TRIM(REGEXP_EXTRACT(version, ';(.*)'))
  END
);

SELECT
  client,
  COMPILER(JSON_EXTRACT_SCALAR(payload, '$._font_details.names[5]')) AS compiler,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  type = 'font'
GROUP BY
  client,
  compiler
ORDER BY
  client,
  proportion DESC
