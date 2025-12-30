#standardSQL

SELECT
  client,
  COUNTIF(SAFE_CAST(JSON_VALUE(custom_metrics.other.llms_txt_validation.valid) AS BOOL)) AS valid_llms,
  COUNT(0) AS total,
  COUNTIF(SAFE_CAST(JSON_VALUE(custom_metrics.other.llms_txt_validation.valid) AS BOOL)) / COUNT(0) AS pct_valid_llms
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01' AND
  is_root_page = TRUE
GROUP BY
  client
ORDER BY
  client
