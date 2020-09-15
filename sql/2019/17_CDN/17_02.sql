#standardSQL
# 17_02: Percentage of the sites which use a CDN for any resource
SELECT
    client,
    COUNTIF(firstHtml) as htmlHits,
    COUNTIF(not firstHtml and sameHost) as domainHits,
    COUNTIF(not sameHost and sameDomain) as subdomainHits,
    COUNTIF(not sameHost and not sameDomain) as thirdPartyHits,
    COUNT(0) AS hits,
    sum(if(firstHtml, respBodySize, 0)) as htmlBytes,
    sum(if(not firstHtml and sameHost, respBodySize, 0)) as domainBytes,
    sum(if(not sameHost and sameDomain, respBodySize, 0)) as subdomainBytes,
    sum(if(not sameHost and not sameDomain, respBodySize, 0)) as thirdPartyBytes,
    sum(respBodySize) as bytes,

    COUNTIF(cdn != 'ORIGIN') AS cdnHits,
    ROUND((COUNTIF(cdn != 'ORIGIN') * 100) / count(0), 2) AS hitsPct,
    sum(case when cdn != 'ORIGIN' then respBodySize else 0 end) as cdnBytes,
    ROUND((sum(case when _cdn_provider != '' then respBodySize else 0 end) * 100) / sum(respBodySize), 2) AS bytesPct
  FROM
    (
      SELECT
        client, page, url, firstHtml, respBodySize,
        ifnull(nullif(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') as cdn,
        case when NET.HOST(url) = NET.HOST(page) then true else false end sameHost,
        case when NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page) then true else false end sameDomain # if toplevel reg_domain will return null so we group this as sameDomain
      FROM `httparchive.almanac.requests3`
      --GROUP BY client, pageid, requestid, page, url, firstHtml, _cdn_provider, respBodySize
    )
  GROUP BY
    client DESC,
    hits DESC