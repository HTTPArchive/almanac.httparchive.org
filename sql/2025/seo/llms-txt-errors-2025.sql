#standardSQL

-- valid = TRUE means "present" or "exists"
-- "errors" are likely validation errors, but may/may not still work
WITH found AS (
  SELECT
    SAFE_CAST(JSON_VALUE(custom_metrics.other.llms_txt_validation.valid) AS BOOL) AS valid,
    JSON_VALUE(custom_metrics.other.llms_txt_validation.error) AS error
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE AND
    custom_metrics.other.llms_txt_validation IS NOT NULL
)

SELECT
  valid,
  error,
  COUNT(0) AS pages,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER ()) AS pct_of_found
FROM
  found
GROUP BY
  valid,
  error
ORDER BY
  valid DESC,
  pages DESC,
  error
