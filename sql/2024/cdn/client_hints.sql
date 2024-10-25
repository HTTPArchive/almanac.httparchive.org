SELECT 
DISTINCT(COUNT(*)) AS Total
FROM `httparchive.all.requests`
WHERE date = "2024-06-01"
UNION ALL
SELECT 
DISTINCT(COUNT(req)) AS ClientHints
FROM `httparchive.all.requests` AS req,
UNNEST(response_headers) as header
WHERE date = "2024-06-01"
AND header.name = 'accept-ch'
AND header.value IS NOT NULL