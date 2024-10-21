WITH pages AS (
  SELECT page, client, array_length(JSON_QUERY_ARRAY(custom_metrics, '$.privacy.fingerprinting.likelyFingerprintingScripts')) AS script_count, count(DISTINCT page) OVER (PARTITION BY client) AS total_pages FROM `httparchive.all.pages` --TABLESAMPLE SYSTEM (0.01 PERCENT)
  WHERE date = '2024-06-01'
)
SELECT script_count, client, count(DISTINCT page) AS page_count, count(DISTINCT page) / any_value(total_pages) AS pct_pages FROM pages GROUP BY script_count, client ORDER BY script_count ASC;
