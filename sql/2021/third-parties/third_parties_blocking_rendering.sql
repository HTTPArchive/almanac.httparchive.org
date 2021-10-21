#standardSQL
# Third-Party domains which render block paint
#
# Unlike the blocking main thread queries, light nhouse only contains details if the
# third-party is render blocking (i.e. wastedMs/total_bytes are never 0)
# And also there are no categories given to each third-party
# So we join to the usual almanac.third_parties table to get those totals and categories
#
# Based heavily on research by Houssein Djirdeh:
# https://docs.google.com/spreadsheets/d/1Td-4qFjuBzxp8af_if5iBC0Lkqm_OROb7_2OcbxrU_g/edit?resourcekey=0-ZCfve5cngWxF0-sv5pLRzg#gid=1628564987

WITH
total_third_party_usage AS (
  SELECT
    canonicalDomain,
    category,
    COUNT(DISTINCT sp.url) AS total_pages
  FROM
    `httparchive.summary_pages.2021_07_01_mobile` sp
  INNER JOIN
    `httparchive.summary_requests.2021_07_01_mobile` sr
  USING (pageid)
  INNER JOIN
    `httparchive.almanac.third_parties`
  ON
    NET.HOST(sr.url) = NET.HOST(domain) AND
    date = '2021-07-01' AND
    category != 'hosting'
  GROUP BY
    canonicalDomain,
    category
)

SELECT
  canonicalDomain,
  category,
  total_pages,
  COUNT(0) AS blocking_pages,
  total_pages - COUNT(0) AS non_blocking_pages,
  COUNT(0) / total_pages AS blocking_pages_pct,
  1 - (COUNT(0) / total_pages) AS non_blocking_pages_pct,
  APPROX_QUANTILES(wasted_ms, 1000)[OFFSET(500)] AS p50_wastedMs,
  APPROX_QUANTILES(total_bytes_kib, 1000)[OFFSET(500)] AS p50_total_bytes_kib
FROM (
  SELECT
    canonicalDomain,
    domain,
    page,
    category,
    SUM(SAFE_CAST(JSON_VALUE(renderBlockingItems, "$.wastedMs") AS FLOAT64)) AS wasted_ms,
    SUM(SAFE_CAST(JSON_VALUE(renderBlockingItems, "$.totalBytes") AS FLOAT64) / 1024) AS total_bytes_kib
  FROM
    (
      SELECT
        url AS page,
        report
      FROM
        `httparchive.lighthouse.2021_07_01_mobile`
    ),
    UNNEST(JSON_QUERY_ARRAY(report, '$.audits.render-blocking-resources.details.items')) AS renderBlockingItems
  INNER JOIN
    `httparchive.almanac.third_parties`
  ON
    NET.HOST(JSON_VALUE(renderBlockingItems, "$.url")) = domain
  GROUP BY
    canonicalDomain,
    domain,
    page,
    category
  )
INNER JOIN
  total_third_party_usage
USING (canonicalDomain, category)
GROUP BY
  canonicalDomain,
  category,
  total_pages
ORDER BY
  total_pages DESC,
  category
LIMIT 200
