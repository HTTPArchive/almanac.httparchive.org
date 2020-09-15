#standardSQL
# 04_09a: Client Hints
SELECT client,
  countif(chHTML) chHTMLCount,
  countif(chHeader) chHeaderCount,
  countif(chHTML AND chHeader) chBothCount,
  countif(chHTML OR chHeader) chEitherCount,
  count(0) as total,
  round(100*countif(chHTML) / count(0), 2) chHTMLPct,
  round(100*countif(chHeader) / count(0), 2) chHeaderPct,
  round(100*countif(chHTML AND chHeader) / count(0), 2) chBothPct,
  round(100*countif(chHTML OR chHeader) / count(0), 2) chEitherPct
FROM
(
  SELECT
    client,
    page,
    regexp_contains(body, r'(?is)<meta[^><]*Accept-CH\b') chHTML,
    regexp_contains(respOtherHeaders, r'(?is)Accept-CH = ') chHeader
  FROM `httparchive.almanac.summary_response_bodies`
  WHERE firstHtml
)
GROUP BY
  client