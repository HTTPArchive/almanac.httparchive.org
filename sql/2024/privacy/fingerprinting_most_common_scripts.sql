SELECT client, script, count(DISTINCT page) AS page_count FROM `httparchive.all.pages`, --TABLESAMPLE SYSTEM (0.001 PERCENT)
  unnest(JSON_QUERY_ARRAY(custom_metrics, '$.privacy.fingerprinting.likelyFingerprintingScripts')) AS script WHERE date = '2024-06-01' GROUP BY client, script ORDER BY page_count DESC LIMIT 100;
