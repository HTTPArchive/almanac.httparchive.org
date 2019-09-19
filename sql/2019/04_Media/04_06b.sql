#standardSQL
# 04_06b: Usage of source[sizes]
SELECT
  client,
  size,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER () AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(body, r'<source[^>]*sizes=[\'"]?([^\'"]*)')) AS sizes,
  UNNEST(REGEXP_EXTRACT_ALL(sizes, r'([^,\'"]*?)(?:[,]|$)')) AS size
WHERE
  firstHtml
GROUP BY
  client,
  size
ORDER BY
  freq / total DESC
LIMIT
  200