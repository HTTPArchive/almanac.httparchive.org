#standardSQL
# summary_pages data grouped by device

# live is very cheap

CREATE TEMP FUNCTION AS_PERCENT(freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(TRIM(doctype) != '') AS freq_doctype,
  COUNT(0) AS total,
  AS_PERCENT(COUNTIF(TRIM(doctype) != ''), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_doctype_m102,
  MIN(bytesHtml) AS min_bytes_html_m109,
  MAX(bytesHtml) AS max_bytes_html_m108,
  ROUND(AVG(bytesHtml), 0) AS avg_bytes_html_m110,
  COUNTIF(bytesHtml = 0) AS freq_zero_bytes_html,
  AS_PERCENT(COUNTIF(bytesHtml = 0), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_zero_bytes_html
FROM
  `httparchive.summary_pages.2020_08_01_*`
GROUP BY
  client
ORDER BY
  client
