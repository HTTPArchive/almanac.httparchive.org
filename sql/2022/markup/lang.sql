WITH langs AS (
  SELECT
    _TABLE_SUFFIX AS client,
    TRIM(LOWER(JSON_VALUE(JSON_VALUE(payload, '$._almanac'), '$.html_node.lang'))) AS lang
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  client,
  IFNULL(lang, '(not set)') AS html_lang_region,
  IFNULL(REGEXP_EXTRACT(lang, r'^([^\-]+)'), '(not set)') AS html_lang,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_pages
FROM
  langs
GROUP BY
  client,
  lang
HAVING
  freq > 100
ORDER BY
  pct DESC
