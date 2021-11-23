#standardSQL
# top_cdns_by_rank.sql: Top CDNs used on the root HTML pages by CrUX rank
SELECT
  client,
  nested_rank,
  cdn,
  COUNTIF(firstHtml) AS firstHtmlHits,
  SUM(COUNTIF(firstHtml)) OVER (PARTITION BY client) AS firstHtmlTotalHits,
  SAFE_DIVIDE(COUNTIF(firstHtml), SUM(COUNTIF(firstHtml)) OVER (PARTITION BY client)) AS firstHtmlHitsPct,

  COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain) AS subDomainHits,
  SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain)) OVER (PARTITION BY client) AS subDomainTotalHits,
  SAFE_DIVIDE(COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain), SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain)) OVER (PARTITION BY client)) AS subDomainHitsPct,

  COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain) AS thirdPartyHits,
  SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain)) OVER (PARTITION BY client) AS thirdPartyTotalHits,
  SAFE_DIVIDE(COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain), SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain)) OVER (PARTITION BY client)) AS thirdPartyHitsPct,

  COUNT(0) AS hits,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS totalHits,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS hitsPct
FROM (
  SELECT
    client,
    rank,
    page,
    url,
    firstHtml,
    respBodySize,
    IFNULL(NULLIF(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') AS cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
    NET.HOST(url) = NET.HOST(page) AS sameHost,
    NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page) AS sameDomain # if toplevel reg_domain will return NULL so we group this as sameDomain
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01'),
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS nested_rank
WHERE
  rank <= nested_rank
GROUP BY
  client,
  nested_rank,
  cdn
ORDER BY
  client DESC,
  nested_rank,
  firstHtmlHits DESC
