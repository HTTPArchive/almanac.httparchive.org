#standardSQL
# top_cdns_by_rank.sql: Top CDNs used on the root HTML pages by CrUX rank
SELECT
  client,
  rank,
  cdn,
  COUNTIF(firstHtml) AS firstHtmlHits,
  SUM(COUNTIF(firstHtml)) OVER (PARTITION BY client) AS firstHtmlTotalHits,
  ROUND((COUNTIF(firstHtml) * 100 / (0.001 + SUM(COUNTIF(firstHtml)) OVER (PARTITION BY client))), 2) AS firstHtmlHitsPct,
  
  COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain) AS subDomainHits,
  SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain)) OVER (PARTITION BY client) AS subDomainTotalHits,
  ROUND((COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain) * 100 / (0.001 + SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain)) OVER (PARTITION BY client))), 2) AS subDomainHitsPct,
  
  COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain) AS thirdPartyHits,
  SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain)) OVER (PARTITION BY client) AS thirdPartyTotalHits,
  ROUND((COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain) * 100 / (0.001 + SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain)) OVER (PARTITION BY client))), 2) AS thirdPartyHitsPct,

  COUNT(0) AS hits,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS totalHits,
  ROUND((COUNT(0) * 100 / (0.001 + SUM(COUNT(0)) OVER (PARTITION BY client))), 2) AS hitsPct
FROM
  (
    SELECT
      client, rank, page, url, firstHtml, respBodySize,
      IFNULL(NULLIF(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') AS cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
      IF(NET.HOST(url) = NET.HOST(page), TRUE, FALSE) AS sameHost,
      IF(NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page), TRUE, FALSE) AS sameDomain # if toplevel reg_domain will return NULL so we group this as sameDomain
    FROM `httparchive.almanac.requests`
    WHERE date = "2021-07-01"
  )
GROUP BY
  client,
  rank,
  cdn
ORDER BY
  client DESC,
  rank ASC,
  firstHtmlHits DESC
