#standardSQL
# 04_26: Usage of <img loading=lazy>
SELECT
  client,
  COUNTIF(REGEXP_CONTAINS(body, r'(?im)<(?:source|img)[^>]*loading=[\'"]?lazy')) AS lazyCount,
  COUNT(0) AS freq
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  date = '2019-07-01' AND
  firstHtml
GROUP BY
  client
ORDER BY
  client DESC
