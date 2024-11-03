WITH pages AS (
  SELECT
    page,
    client,
    ARRAY_LENGTH(JSON_QUERY_ARRAY(custom_metrics, '$.privacy.fingerprinting.likelyFingerprintingScripts')) AS script_count,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_pages
  FROM `httparchive.all.pages`
  WHERE date = '2024-06-01'
)

SELECT
  script_count,
  client,
  COUNT(DISTINCT page) AS page_count,
  COUNT(DISTINCT page) / any_value(total_pages) AS pct_pages
FROM pages
GROUP BY
  script_count,
  client
ORDER BY
  script_count ASC;
