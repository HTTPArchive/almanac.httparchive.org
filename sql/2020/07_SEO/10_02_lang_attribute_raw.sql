#standardSQL
# 10_02: lang attribute usage and mistakes (lang='en')
# source: https://discuss.httparchive.org/t/what-are-the-invalid-uses-of-the-lang-attribute/1022
SELECT
  client,
  LOWER(REGEXP_EXTRACT(body, '(?i)<html[^>]*lang=[\'"]?([a-z]{2})')) AS lang,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  firstHtml
GROUP BY
  client,
  lang
ORDER BY
  freq / total DESC