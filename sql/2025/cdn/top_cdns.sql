#standardSQL
# top_cdns.sql: Top CDNs used
SELECT
  year,
  client,
  cdn,
  COUNTIF(firstHtml) AS firstHtmlHits,
  SUM(COUNTIF(firstHtml)) OVER (PARTITION BY year, client) AS firstHtmlTotalHits,
  SAFE_DIVIDE(COUNTIF(firstHtml), SUM(COUNTIF(firstHtml)) OVER (PARTITION BY year, client)) AS firstHtmlHitsPct,

  COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain) AS subDomainHits,
  SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain)) OVER (PARTITION BY year, client) AS subDomainTotalHits,
  SAFE_DIVIDE(COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain), SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND sameDomain)) OVER (PARTITION BY year, client)) AS subDomainHitsPct,

  COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain) AS thirdPartyHits,
  SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain)) OVER (PARTITION BY year, client) AS thirdPartyTotalHits,
  SAFE_DIVIDE(COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain), SUM(COUNTIF(NOT firstHtml AND NOT sameHost AND NOT sameDomain)) OVER (PARTITION BY year, client)) AS thirdPartyHitsPct,

  COUNT(0) AS hits,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS totalHits,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS hitsPct
FROM
  (
    SELECT
      '2019' AS year,
      client,
      page,
      url,
      is_main_document AS firstHtml,
      IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'ORIGIN') AS cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
      NET.HOST(url) = NET.HOST(page) AS sameHost,
      NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page) AS sameDomain # if toplevel reg_domain will return NULL so we group this as sameDomain
    FROM
      `httparchive.crawl.requests`
    WHERE
      date = '2019-07-01'
    UNION ALL
    SELECT
      '2020' AS year,
      client,
      page,
      url,
      is_main_document AS firstHtml,
      IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'ORIGIN') AS cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
      NET.HOST(url) = NET.HOST(page) AS sameHost,
      NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page) AS sameDomain # if toplevel reg_domain will return NULL so we group this as sameDomain
    FROM
      `httparchive.crawl.requests`
    WHERE
      date = '2020-08-01'
    UNION ALL
    SELECT
      '2021' AS year,
      client,
      page,
      url,
      is_main_document AS firstHtml,
      IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'ORIGIN') AS cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
      NET.HOST(url) = NET.HOST(page) AS sameHost,
      NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page) AS sameDomain # if toplevel reg_domain will return NULL so we group this as sameDomain
    FROM
      `httparchive.crawl.requests`
    WHERE
      date = '2021-07-01'
    UNION ALL
    SELECT
      '2022' AS year,
      client,
      page,
      url,
      is_main_document AS firstHtml,
      IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'ORIGIN') AS cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
      NET.HOST(url) = NET.HOST(page) AS sameHost,
      NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page) AS sameDomain # if toplevel reg_domain will return NULL so we group this as sameDomain
    FROM
      `httparchive.crawl.requests`
    WHERE
      date = '2022-06-01'
    UNION ALL
    SELECT
      '2024' AS year,
      client,
      page,
      url,
      is_main_document AS firstHtml,
      IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'ORIGIN') AS cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
      NET.HOST(url) = NET.HOST(page) AS sameHost,
      NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page) AS sameDomain # if toplevel reg_domain will return NULL so we group this as sameDomain
    FROM
      `httparchive.crawl.requests`
    WHERE
      date = '2024-06-01'
    UNION ALL
    SELECT
      '2025' AS year,
      client,
      page,
      url,
      is_main_document AS firstHtml,
      IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'ORIGIN') AS cdn, # sometimes _cdn provider detection includes multiple entries. we bias for the DNS detected entry which is the first entry
      NET.HOST(url) = NET.HOST(page) AS sameHost,
      NET.HOST(url) = NET.HOST(page) OR NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page) AS sameDomain # if toplevel reg_domain will return NULL so we group this as sameDomain
    FROM
      `httparchive.crawl.requests`
    WHERE
      date = '2025-07-01'
  )
GROUP BY
  year,
  client,
  cdn
ORDER BY
  year DESC,
  client DESC,
  firstHtmlHits DESC
