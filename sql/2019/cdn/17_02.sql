#standardSQL
# 17_02: Percentage of the sites which use a CDN for any resource
SELECT
  client,
  COUNTIF(firstHtml) AS htmlHits,
  COUNTIF(NOT firstHtml AND sameHost) AS domainHits,
  COUNTIF(NOT sameHost AND sameDomain) AS subdomainHits,
  COUNTIF(NOT sameHost AND NOT sameDomain) AS thirdPartyHits,
  COUNT(0) AS hits,
  SUM(IF(firstHtml, respBodySize, 0)) AS htmlBytes,
  SUM(IF(NOT firstHtml AND sameHost, respBodySize, 0)) AS domainBytes,
  SUM(IF(NOT sameHost AND sameDomain, respBodySize, 0)) AS subdomainBytes,
  SUM(IF(NOT sameHost AND NOT sameDomain, respBodySize, 0)) AS thirdPartyBytes,
  SUM(respBodySize) AS bytes,

  COUNTIF(cdn != 'ORIGIN') AS cdnHits,
  ROUND((COUNTIF(cdn != 'ORIGIN') * 100) / COUNT(0), 2) AS hitsPct,
  SUM(CASE WHEN cdn != 'ORIGIN' THEN respBodySize ELSE 0 END) AS cdnBytes,
  ROUND((SUM(CASE WHEN _cdn_provider != '' THEN respBodySize ELSE 0 END) * 100) / SUM(respBodySize), 2) AS bytesPct
FROM (
  SELECT
    client, page, url, firstHtml, respBodySize,
    IFNULL(NULLIF(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') AS cdn,
    CASE WHEN NET.HOST(url) = NET.HOST(page) THEN TRUE ELSE FALSE END AS sameHost,
    CASE WHEN NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page) THEN TRUE ELSE FALSE END AS sameDomain # if toplevel reg_domain will return NULL so we group this as sameDomain
  FROM `httparchive.almanac.requests3`
  --GROUP BY client, pageid, requestid, page, url, firstHtml, _cdn_provider, respBodySize
)
GROUP BY
  client,
  hits
