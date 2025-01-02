#standardSQL
# 09_24: % pages with aria-posinset and aria-setsize
SELECT
  client,
  COUNTIF(posinset AND setsize) AS freq,
  COUNT(0) AS total,
  ROUND(COUNTIF(posinset AND setsize) * 100 / COUNT(0), 2) AS pct
FROM (
  SELECT
    client,
    REGEXP_CONTAINS(body, '\\saria-posinset=') AS posinset,
    REGEXP_CONTAINS(body, '\\saria-setsize=') AS setsize
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
