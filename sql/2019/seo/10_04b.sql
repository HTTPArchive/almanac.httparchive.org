#standardSQL
# 10_04b: hreflang implementation values
SELECT
  client,
  NORMALIZE_AND_CASEFOLD(TRIM(hreflang)) AS hreflang,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)<link[^>]*hreflang=[\'"]?([^\'"\\s>]+)')) AS hreflang
WHERE
  date = '2019-07-01'
GROUP BY
  client,
  hreflang
ORDER BY
  freq / total DESC
LIMIT 10000
