WITH pages AS (
  SELECT page, client, custom_metrics, count(DISTINCT page) OVER (PARTITION BY client) AS total_pages FROM `httparchive.all.pages` --TABLESAMPLE SYSTEM (0.001 PERCENT)
  WHERE date = '2024-06-01'
)
SELECT client, script, count(DISTINCT page) AS page_count, count(DISTINCT page) / any_value(total_pages) AS pct_pages FROM pages,
  unnest(JSON_QUERY_ARRAY(custom_metrics, '$.privacy.fingerprinting.likelyFingerprintingScripts')) AS script GROUP BY client, script ORDER BY page_count DESC LIMIT 100;
