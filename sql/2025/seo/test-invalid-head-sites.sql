#standardSQL
# Test query to validate invalid head sites are being detected
# This should return non-zero values if the fix is working

SELECT
  client,
  COUNT(DISTINCT page) AS total_pages,
  COUNTIF(JSON_VALUE(custom_metrics.other.`valid-head`.invalidHead) = 'true') AS pages_with_invalid_head,
  COUNTIF(ARRAY_LENGTH(JSON_QUERY_ARRAY(custom_metrics.other.`valid-head`.invalidElements)) > 0) AS pages_with_invalid_elements,
  SAFE_DIVIDE(COUNTIF(JSON_VALUE(custom_metrics.other.`valid-head`.invalidHead) = 'true'), COUNT(DISTINCT page)) AS pct_invalid_head
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01' AND
  is_root_page = TRUE
GROUP BY
  client
ORDER BY
  client
