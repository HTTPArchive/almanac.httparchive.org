#standardSQL
# 10_04a: has hreflang
SELECT
  client,
  COUNTIF(has_hreflang) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(has_hreflang) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    client,
    REGEXP_CONTAINS(body, '(?i)<link[^>]*hreflang') AS has_hreflang
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
GROUP BY
  client
