-- Temporary function to extract bytesHtml
CREATE TEMPORARY FUNCTION EXTRACT_DOCTYPE(summary STRING) RETURNS INT64 AS (
  SAFE_CAST(JSON_EXTRACT(summary, '$.bytesHtml') AS INT64)
);

SELECT
  percentile,
  client,
  APPROX_QUANTILES(EXTRACT_DOCTYPE(summary) / 1014, 1000)[OFFSET(percentile * 10)] AS kb_html
FROM
  `httparchive.all.pages`,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  date = '2024-06-01'
GROUP BY
  percentile,
  client
ORDER BY
  client
