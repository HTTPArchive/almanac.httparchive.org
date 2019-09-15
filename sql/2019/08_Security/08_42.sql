#standardSQL
# 08_42: % pages with Clear-Site-Data header
SELECT
  client,
  COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)clear-site-data =')) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(REGEXP_CONTAINS(respOtherHeaders, '(?i)clear-site-data =')) * 100 / COUNT(0), 2) AS pct
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  firstHtml
GROUP BY
  client