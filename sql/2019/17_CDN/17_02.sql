#standardSQL
# 17_02: Percentage of the sites which use a CDN for any resource
SELECT
    client,
    firstHtml,
    sameHost,
    sameDomain,
    not sameHost AND not sameDomain AS thirdParty,
    COUNTIF(_cdn_provider != '') AS cdnHits,
    COUNT(0) AS hits,
    ROUND((COUNTIF(_cdn_provider != '') * 100) / count(0), 2) AS hitsPct,
    sum(case when _cdn_provider != '' then respBodySize else 0 end) as cdnBytes,
    sum(respBodySize) as bytes,
    ROUND((sum(case when _cdn_provider != '' then respBodySize else 0 end) * 100) / sum(respBodySize), 2) AS bytesPct
  FROM
    (
      SELECT
        client, pageid, requestid, page, url, firstHtml, _cdn_provider, respBodySize,
        case when NET.HOST(url) = NET.HOST(page) then true else false end sameHost,
        case when NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page) then true else false end sameDomain # if toplevel reg_domain will return null so we group this as sameDomain
      FROM `httparchive.almanac.requests`
      GROUP BY client, pageid, requestid, page, url, firstHtml, _cdn_provider, respBodySize
    )
  GROUP BY
    client,
    firstHtml,
    sameHost,
    sameDomain