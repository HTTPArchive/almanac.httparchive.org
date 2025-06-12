#standardSQL
# 09_22: % pages with aria-hidden on body
SELECT
  client,
  COUNTIF(hides_body) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(hides_body) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    client,
    REGEXP_CONTAINS(body, '<body[^>]+aria-hidden') AS hides_body
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
GROUP BY
  client
ORDER BY
  freq / total DESC
