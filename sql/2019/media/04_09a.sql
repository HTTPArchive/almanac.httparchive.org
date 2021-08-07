#standardSQL
# 04_09a: Client Hints
SELECT client,
  COUNTIF(chHTML) chHTMLCount,
  COUNTIF(chHeader) chHeaderCount,
  COUNTIF(chHTML AND chHeader) chBothCount,
  COUNTIF(chHTML OR chHeader) chEitherCount,
  COUNT(0) AS total,
  ROUND(100*COUNTIF(chHTML) / COUNT(0), 2) chHTMLPct,
  ROUND(100*COUNTIF(chHeader) / COUNT(0), 2) chHeaderPct,
  ROUND(100*COUNTIF(chHTML AND chHeader) / COUNT(0), 2) chBothPct,
  ROUND(100*COUNTIF(chHTML OR chHeader) / COUNT(0), 2) chEitherPct
FROM
(
  SELECT
    client,
    page,
    REGEXP_CONTAINS(body, r'(?is)<meta[^><]*Accept-CH\b') chHTML,
    REGEXP_CONTAINS(respOtherHeaders, r'(?is)Accept-CH = ') chHeader
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
GROUP BY
  client
