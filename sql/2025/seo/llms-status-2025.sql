#standardSQL
WITH home AS (
  SELECT
    JSON_QUERY(custom_metrics.other, '$.llms_txt_validation') AS obj,
    SAFE_CAST(JSON_VALUE(custom_metrics.other, '$.llms_txt_validation.valid') AS BOOL) AS valid
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01' 
    AND is_root_page = TRUE
),
labeled AS (
  SELECT
    CASE
      WHEN valid IS TRUE THEN 'Valid LLMs'
      WHEN valid IS FALSE THEN 'Non-Valid LLMs'
      ELSE 'Non-Valid LLMs'
    END AS bucket
  FROM home
)
SELECT
  bucket,
  COUNT(*) AS pages,
  SAFE_DIVIDE(COUNT(*), SUM(COUNT(*)) OVER ()) AS pct
FROM labeled
GROUP BY bucket
ORDER BY pages DESC;
