#standardSQL
# 04_06b: Usage of source[sizes]
SELECT
  client,
  sizes,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER () AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(body, r'(?im)<(?:source|img)[^>]*sizes=[\'"]?([^\'"]*)')) AS sizes
WHERE
  date = '2019-07-01' AND
  firstHtml
GROUP BY
  client,
  sizes
ORDER BY
  client DESC,
  freq DESC
