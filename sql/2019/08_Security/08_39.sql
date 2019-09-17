#standardSQL
# 08_39: SRI
SELECT
  client,
  COUNTIF(REGEXP_CONTAINS(body, '(?i)<(?:link|script)[^>]*integrity=')) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(REGEXP_CONTAINS(body, '(?i)<(?:link|script)[^>]*integrity=')) / COUNT(0), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  firstHtml
GROUP BY
  client