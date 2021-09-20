#standardSQL
# summary_pages trends grouped by device

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

WITH summary_requests AS (
  SELECT
    '2019' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.summary_pages.2019_07_01_*`
UNION ALL
  SELECT
    '2020' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.summary_pages.2020_08_01_*`
UNION ALL
  SELECT
    '2021' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.summary_pages.2021_07_01_*`
)

SELECT
  year,
  client,
  COUNTIF(TRIM(doctype) <> '') AS freq_doctype,
  AS_PERCENT(COUNTIF(TRIM(doctype) <> ''), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct_doctype_m102, 
  MIN(bytesHtml) AS min_bytes_html_m103, 
  MAX(bytesHtml) AS max_bytes_html_m104, 
  ROUND(AVG(bytesHtml),0) AS avg_bytes_html_m105, 
  COUNTIF(bytesHtml = 0) AS freq_zero_bytes_html,
  AS_PERCENT(COUNTIF(bytesHtml = 0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct_zero_bytes_html
FROM
  summary_requests
GROUP BY
  year,
  client
ORDER BY
  year,
  client
