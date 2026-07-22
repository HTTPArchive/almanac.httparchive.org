# Note due to a problem with doctypes this doesn't actually return data for '2025-07-01' but will for later years

SELECT
  client,
  LOWER(REGEXP_REPLACE(TRIM(JSON_VALUE(custom_metrics.other.doctype)), r' +', ' ')) AS doctype, # remove extra spaces and make lower case
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_pages
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01'
GROUP BY
  client,
  doctype
ORDER BY
  pct_pages DESC
LIMIT
  100;
