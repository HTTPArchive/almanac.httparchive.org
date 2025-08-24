#standardSQL

-- valid = TRUE means "present" or "exists" 
-- "errors" are likely validation errors, but may/may not still work
WITH found AS (
  SELECT
    SAFE_CAST(JSON_VALUE(custom_metrics.other, '$.llms_txt_validation.valid') AS BOOL) AS valid,
    JSON_VALUE(custom_metrics.other, '$.llms_txt_validation.error') AS error
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
    AND is_root_page = TRUE
    AND JSON_QUERY(custom_metrics.other, '$.llms_txt_validation') IS NOT NULL
)
SELECT
  valid,
  error,
  COUNT(*) AS pages,
  SAFE_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER ()) AS pct_of_found
FROM found
GROUP BY valid, error
ORDER BY valid DESC, pages DESC;
