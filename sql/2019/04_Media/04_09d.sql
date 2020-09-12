#standardSQL
# 04_09c: Top Client Hints
SELECT
  client,
  COUNTif(regexp_contains(body, r'(?is)<meta[^><]*Accept-CH\b') OR regexp_contains(respOtherHeaders, r'(?im)Accept-CH = ')) AS acceptFreq,
  count(0) total
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  firstHtml
  AND REGEXP_contains(body, r'(?im)<(?:source|img)[^>]*sizes=[\'"]?([^\'"]*)')
GROUP BY
  client
ORDER BY
  client DESC,
  total DESC
