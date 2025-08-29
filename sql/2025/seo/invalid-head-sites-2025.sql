#standardSQL
# Counted metrics of invalid head elements in HTML

WITH totals AS (
  SELECT
    client,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE  THEN 'Homepage'
      ELSE 'No Assigned Page'
    END AS is_root_page,
    page,
    JSON_EXTRACT_SCALAR(
      TO_JSON_STRING(custom_metrics.other),
      '$[\'valid-head\'][\'invalidHead\']'
    ) AS invalidHead,
    ARRAY_LENGTH(
      IFNULL(
        JSON_EXTRACT_ARRAY(
          TO_JSON_STRING(custom_metrics.other),
          '$[\'valid-head\'][\'invalidElements\']'
        ),
        []
      )
    ) AS invalidCount
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
)

SELECT
  client,
  is_root_page,
  COUNTIF(invalidHead = 'true') AS invalidHeads,
  SUM(invalidCount) AS invalidCount,
  SAFE_DIVIDE(COUNTIF(invalidHead = 'true'), COUNT(DISTINCT page)) AS pct_invalidHeads,
  COUNT(DISTINCT page) AS sites,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS total,
  COUNT(0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS pct
FROM totals
GROUP BY client, is_root_page
ORDER BY client;