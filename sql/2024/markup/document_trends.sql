-- Temporary function to extract bytesHtml
CREATE TEMPORARY FUNCTION EXTRACT_DOCTYPE(summary STRING) RETURNS INT64 AS (
  SAFE_CAST(JSON_EXTRACT(summary, '$.bytesHtml') AS INT64)
);

SELECT
  date,
  client,
  APPROX_QUANTILES(EXTRACT_DOCTYPE(summary) / 1024, 1000)[OFFSET(500)] AS median_kbytes_html,
  COUNT(0) AS total
FROM
  `httparchive.all.pages`
WHERE
  date IN ('2022-06-01', '2023-06-01', '2024-06-01')
GROUP BY
  date,
  client
ORDER BY
  date,
  client
