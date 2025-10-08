#standardSQL
# Counted metrics of invalid head elements in HTML
WITH totals AS (
  SELECT
    client,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END
      AS is_root_page,
    payload,
    page,
    JSON_QUERY(payload, '$._valid-head.invalidHead') AS invalidHead,
    ARRAY_LENGTH(JSON_EXTRACT_ARRAY(payload, '$._valid-head.invalidElements')) AS invalidCount
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01'
  GROUP BY
    client,
    page,
    is_root_page,
    payload
)

SELECT
  client,
  is_root_page,
  COUNTIF(invalidHead = 'true') AS invalidHeads,
  SUM(invalidCount) AS invalidCount,
  COUNTIF(invalidHead = 'true') / COUNT(DISTINCT page) AS pct_invalidHeads,
  COUNT(DISTINCT page) AS sites,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS total,
  COUNT(0) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client, is_root_page) AS pct
FROM
  totals
GROUP BY
  client,
  is_root_page
ORDER BY
  client
