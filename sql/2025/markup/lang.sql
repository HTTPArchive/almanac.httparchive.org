WITH langs AS (
  SELECT
    client,
    TRIM(LOWER(JSON_VALUE(custom_metrics.other.almanac.html_node.lang))) AS lang
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2026-07-01'
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
  pages > 100
ORDER BY
  pct_pages DESC
