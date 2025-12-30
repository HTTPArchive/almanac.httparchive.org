#standardSQL

-- valid = TRUE means "present" or "exists"
WITH labeled AS (
  SELECT
    client,
    CASE SAFE_CAST(JSON_VALUE(custom_metrics.other.llms_txt_validation.valid) AS BOOL)
      WHEN TRUE THEN 'Valid LLMs'
      WHEN FALSE THEN 'Non-Valid LLMs'
      ELSE 'Non-Valid LLMs'
    END AS bucket
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE
)

SELECT
  client,
  bucket,
  COUNT(0) AS pages,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct
FROM
  labeled
GROUP BY
  client,
  bucket
ORDER BY
  client,
  pages DESC;
