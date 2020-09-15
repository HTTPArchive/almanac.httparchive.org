#standardSQL
# 04_26: Usage of <img loading=lazy>
SELECT
  client,
  countif(REGEXP_CONTAINS(body, r'(?im)<(?:source|img)[^>]*loading=[\'"]?lazy')) as lazyCount,
  COUNT(0) AS freq
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  firstHtml
GROUP BY
  client
ORDER BY
  client DESC