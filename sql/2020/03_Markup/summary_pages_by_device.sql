#standardSQL
# summary_pages data grouped by device

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(TRIM(doctype) <> '') AS freq_doctype,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  AS_PERCENT(COUNTIF(TRIM(doctype) <> ''), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_doctype_m102, 
  MIN(bytesHtml) AS min_bytes_html_m109, 
  MAX(bytesHtml) AS max_bytes_html_m108, 
  ROUND(AVG(bytesHtml),0) AS avg_bytes_html_m110, 
  COUNTIF(bytesHtml = 0) AS freq_zero_bytes_html,
  AS_PERCENT(COUNTIF(bytesHtml = 0), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_zero_bytes_html
FROM
  `httparchive.sample_data.summary_pages_*`
GROUP BY
  client
ORDER BY
  client
