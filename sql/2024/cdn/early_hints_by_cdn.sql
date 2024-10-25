SELECT 
DISTINCT(COUNT(*)) AS hints,
client,
REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*') AS cdn
FROM `httparchive.all.requests`
WHERE date = "2024-06-01"
AND JSON_EXTRACT_ARRAY(payload, '$._early_hint_headers') IS NOT NULL
AND REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*') IS NOT NULL
GROUP BY cdn, client