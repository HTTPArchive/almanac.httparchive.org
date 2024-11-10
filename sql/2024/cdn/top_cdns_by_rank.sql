#standardSQL
# top_cdns_by_rank.sql: Top CDNs used on the root HTML pages by CrUX rank

WITH requests AS (
  SELECT
    client,
    is_main_document AS firstHtml,
    page,
    url,
    rank,
    -- _cdn_provider is now in requests.summary table
    -- Also it returns empty string ('')rather than 'ORIGIN' when no CDN
    IF(IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(resp.summary, '$._cdn_provider'), r'^([^,]*).*'), ''), '') = '', 'ORIGIN', 'CDN') AS cdn,
    NET.HOST(url) = NET.HOST(page) AS sameHost,
    NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page) AS sameDomain # if toplevel reg_domain will return NULL so we group this as sameDomain
  FROM
    `httparchive.all.requests` AS resp -- NEW table
  INNER JOIN
    `httparchive.all.pages` -- NEW pages table
  -- `httparchive.sample_data.pages_1k` AS pages -- SAMPLE pages table (quicker)
  USING (page, client, date)
  WHERE
    date = '2024-06-01' AND -- Uncomment this when running on full table
    is_main_document -- new name for firstHtml
)

SELECT
  client,
  rank_grouping,
  CASE
    WHEN rank_grouping = 100000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
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
FROM requests,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping,
  cdn
ORDER BY
  client DESC,
  rank_grouping,
  firstHtmlHits DESC
