#standardSQL
# hreflang implementation values
# use the rendered one instead
# See related: sql/2019/10_SEO/10_04b.sql

SELECT
###  client,
  _TABLE_SUFFIX AS client, ### remove when real

  NORMALIZE_AND_CASEFOLD(TRIM(hreflang)) AS hreflang,
  COUNT(0) AS freq,
###  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
###   ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total, ### remove when real
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct ### remove when real
FROM
  `httparchive.almanac.response_bodies_*`  # should be httparchive.almanac.summary_response_bodies and uncomment ###s real one costs a lot!
  , UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)<link[^>]*hreflang=[\'"]?([^\'"\\s>]+)')) AS hreflang
###  WHERE
###    firstHtml
GROUP BY
  client,
  hreflang
ORDER BY
  freq / total DESC
LIMIT
  10000