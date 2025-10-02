#standardSQL

-- Query to return root pages where both is_root_page = TRUE and Valid LLMs = TRUE
SELECT DISTINCT
  url,
  JSON_QUERY(custom_metrics.other, '$.llms_txt_validation') AS llms_validation_obj,
  SAFE_CAST(JSON_VALUE(custom_metrics.other, '$.llms_txt_validation.valid') AS BOOL) AS valid_llms
FROM `httparchive.crawl.pages`
WHERE date = '2025-07-01' 
  AND is_root_page = TRUE
  AND SAFE_CAST(JSON_VALUE(custom_metrics.other, '$.llms_txt_validation.valid') AS BOOL) = TRUE
ORDER BY url;
