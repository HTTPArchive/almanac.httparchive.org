#standardSQL
# 17_01: Top CDNs used on the root HTML pages
SELECT
  client,
  cdn,
  COUNTIF(firstHtml) AS firstHtmlHits,
  COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain) AS subDomainHits,
  COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain) AS thirdPartyHits,
  COUNT(0) AS hits,
  SUM(COUNTIF(firstHtml)) OVER (PARTITION BY client) AS firstHtmlTotalHits,
  ROUND((COUNTIF(firstHtml) * 100 / (0.001 + SUM(COUNTIF(firstHtml)) OVER (PARTITION BY client))), 2) AS firstHtmlHitsPct,
  SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain)) OVER (PARTITION BY client) AS subDomainTotalHits,
  ROUND((COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain) * 100 / (0.001 + SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain)) OVER (PARTITION BY client))), 2) AS subDomainHitsPct,
  SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain)) OVER (PARTITION BY client) AS thirdPartyTotalHits,
  ROUND((COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain) * 100 / (0.001 + SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain)) OVER (PARTITION BY client))), 2) AS thirdPartyHitsPct,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS totalHits,
  ROUND((COUNT(0) * 100 / (0.001 + SUM(COUNT(0)) OVER (PARTITION BY client))), 2) AS hitsPct
FROM (
  SELECT
    client, page, url, firstHtml, respBodySize,
    IFNULL(NULLIF(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') AS cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
    IF(NET.HOST(url) = NET.HOST(page), TRUE, FALSE) AS sameHost,
    IF(NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page), TRUE, FALSE) AS sameDomain # if toplevel reg_domain will return NULL so we group this as sameDomain
  FROM `httparchive.almanac.requests3`
)
GROUP BY
  client,
  cdn
ORDER BY
  client DESC,
  firstHtmlHits DESC
