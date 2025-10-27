#standardSQL
# % of pages with a valid html lang attribute

SELECT
  client,
  is_root_page,
  COUNT(0) AS total,
  COUNTIF(valid_lang) AS valid_lang,
  COUNTIF(has_lang) AS has_lang,
  COUNTIF(has_lang) / COUNT(0) AS pct_has_of_total,
  COUNTIF(valid_lang) / COUNT(0) AS pct_valid_of_total
FROM (
  SELECT
    client,
    is_root_page,
    JSON_VALUE(lighthouse.audits.`html-has-lang`.score) = '1' AS has_lang,
    JSON_VALUE(lighthouse.audits.`html-lang-valid`.score) = '1' AS valid_lang
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)
GROUP BY
  client,
  is_root_page
ORDER BY
  client,
  is_root_page;
