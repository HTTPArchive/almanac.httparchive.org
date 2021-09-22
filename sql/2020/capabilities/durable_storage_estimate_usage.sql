#standardSQL
SELECT
  REGEXP_REPLACE(yyyymmdd, r"(\d{4})(\d{2})(\d{2})", "\\1_\\2_\\3") AS date,
  UNIX_DATE(CAST(REGEXP_REPLACE(yyyymmdd, r"(\d{4})(\d{2})(\d{2})", "\\1-\\2-\\3") AS DATE)) * 1000 * 60 * 60 * 24 AS timestamp,
  client,
  num_urls,
  ROUND(num_urls / total_urls * 100, 5) AS percent
FROM
  `httparchive.blink_features.usage`
WHERE
  id = "1371" OR feature = "DurableStorageEstimate"
GROUP BY
  date,
  timestamp,
  client,
  num_urls,
  total_urls
ORDER BY
  date DESC,
  client,
  num_urls DESC
