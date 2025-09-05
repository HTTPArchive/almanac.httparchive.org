SELECT
  (COUNT(0)) AS Total, client,
  IF(IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), '') = '', 'ORIGIN', 'CDN') AS cdn
FROM `httparchive.crawl.requests`
WHERE date = '2025-07-01'
GROUP BY cdn, client
UNION ALL
SELECT
  (COUNT(req)) AS ClientHints, client,
  IF(IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), '') = '', 'ORIGIN', 'CDN') AS cdn
FROM `httparchive.crawl.requests` AS req,
  UNNEST(response_headers) AS header
WHERE date = '2025-07-01' AND
  header.name = 'accept-ch' AND
  header.value IS NOT NULL
GROUP BY cdn, client
