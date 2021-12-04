#standardSQL
# 04_09a: Client Hints
SELECT client,
  COUNTIF(chHTML) AS chHTMLCount,
  COUNTIF(chHeader) AS chHeaderCount,
  COUNTIF(chHTML AND chHeader) AS chBothCount,
  COUNTIF(chHTML OR chHeader) AS chEitherCount,
  COUNT(0) AS total,
  ROUND(100 * COUNTIF( chHTML) / COUNT(0), 2) AS chHTMLPct,
  ROUND(100 * COUNTIF( chHeader) / COUNT(0), 2) AS chHeaderPct,
  ROUND(100 * COUNTIF( chHTML AND chHeader) / COUNT(0), 2) AS chBothPct,
  ROUND(100 * COUNTIF( chHTML OR chHeader) / COUNT(0), 2) AS chEitherPct
FROM
  (
    SELECT
      client,
      page,
      REGEXP_CONTAINS(body, r'(?is)<meta[^><]*Accept-CH\b') AS chHTML,
      REGEXP_CONTAINS(respOtherHeaders, r'(?is)Accept-CH = ') AS chHeader
    FROM
      `httparchive.almanac.summary_response_bodies`
    WHERE
      date = '2019-07-01' AND
      firstHtml
  )
GROUP BY
  client
