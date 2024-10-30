SELECT 
DISTINCT(COUNT(*)) AS Total, client,
IF(IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), '') = '', 'ORIGIN', 'CDN') AS cdn
FROM `httparchive.all.requests`
WHERE date = "2024-06-01"
GROUP BY cdn, client
UNION ALL
SELECT 
DISTINCT(COUNT(req)) AS ClientHints, client,
IF(IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), '') = '', 'ORIGIN', 'CDN') AS cdn
FROM `httparchive.all.requests` AS req,
UNNEST(response_headers) as header
WHERE date = "2024-06-01"
AND header.name = 'accept-ch'
AND header.value IS NOT NULL
GROUP BY cdn, client