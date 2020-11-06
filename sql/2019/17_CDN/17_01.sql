#standardSQL
# 17_01: Top CDNs used on the root HTML pages
SELECT
  client,
  cdn,
  COUNTIF(firstHtml) AS firstHtmlHits,
  COUNTIF(not firstHtml and not sameHost and sameDomain) AS subDomainHits,
  COUNTIF(not firstHtml and not sameHost and not sameDomain) AS thirdPartyHits,
  COUNT(0) AS hits,
  SUM(COUNTIF(firstHtml)) OVER (PARTITION BY client) AS firstHtmlTotalHits,
  ROUND((COUNTIF(firstHtml) * 100 / (0.001 + SUM(COUNTIF(firstHtml)) OVER (PARTITION BY client))), 2) AS firstHtmlHitsPct,
  SUM(COUNTIF(not firstHtml and not sameHost and sameDomain)) OVER (PARTITION BY client) AS subDomainTotalHits,
  ROUND((COUNTIF(not firstHtml and not sameHost and sameDomain) * 100 / (0.001 + SUM(COUNTIF(not firstHtml and not sameHost and sameDomain)) OVER (PARTITION BY client))), 2) AS subDomainHitsPct,
  SUM(COUNTIF(not firstHtml and not sameHost and not sameDomain)) OVER (PARTITION BY client) AS thirdPartyTotalHits,
  ROUND((COUNTIF(not firstHtml and not sameHost and not sameDomain) * 100 / (0.001 + SUM(COUNTIF(not firstHtml and not sameHost and not sameDomain)) OVER (PARTITION BY client))), 2) AS thirdPartyHitsPct,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS totalHits,
  ROUND((COUNT(0) * 100 / (0.001 + SUM(COUNT(0)) OVER (PARTITION BY client))), 2) AS hitsPct
FROM
(
  SELECT
      client, page, url, firstHtml, respBodySize,
      ifnull(nullif(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
      if(NET.HOST(url) = NET.HOST(page), true, false) sameHost,
      if(NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page), true, false) AS sameDomain # if toplevel reg_domain will return null so we group this as sameDomain
    FROM `httparchive.almanac.requests3`
--    GROUP BY client, pageid, requestid, page, url, firstHtml, cdn, respBodySize
)
GROUP BY
  client,
  cdn
ORDER BY
  client DESC,
  firstHtmlHits DESC
