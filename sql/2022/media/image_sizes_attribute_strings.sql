SELECT
  client,
  sizes,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY 0) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY 0) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(body, r'(?im)<(?:source|img)[^>]*sizes=[\'"]?([^\'"]*)')) AS sizes
WHERE
  date = '2021-07-01' AND
  firstHtml
GROUP BY
  client,
  sizes
ORDER BY
  freq DESC
LIMIT
  100
