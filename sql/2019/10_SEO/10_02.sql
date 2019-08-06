#standardSQL

# lang attribute usage and mistakes (lang='en')
# source: https://discuss.httparchive.org/t/what-are-the-invalid-uses-of-the-lang-attribute/1022

SELECT
  LOWER(REGEXP_EXTRACT(body, '(?i)<html[^>]*lang=[\'"]?([a-z]{2})')) AS lang,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  firstHtml
GROUP BY
  lang
ORDER BY
  freq DESC
