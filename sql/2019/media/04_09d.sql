#standardSQL
# 04_09c: Top Client Hints
SELECT
  client,
  COUNTIF(REGEX_CONTAINS(body, r'(?is)<meta[^><]*Accept-CH\b') OR REGEXP_CONTAINS(respOtherHeaders, r'(?im)Accept-CH = ')) AS acceptFreq,
  COUNT(0) AS total
FROM
  `httparchive.almanac.summary_response_bodies`
WHERE
  date = '2019-07-01' AND
  firstHtml AND
  REGEXP_contains(body, r'(?im)<(?:source|img)[^>]*sizes=[\'"]?([^\'"]*)')
GROUP BY
  client
ORDER BY
  client DESC,
  total DESC
