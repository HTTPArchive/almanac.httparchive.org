#standardSQL
# Third-Party domains which render block paint
#
# Unlike the blocking main thread queries, lighthouse only contains details if the
# third-party is render blocking (i.e. wastedMs/total_bytes are never 0)
# And also there are no categories given to each third-party
# So we join to the usual almanac.third_parties table to get those totals and categories
#
# Based heavily on research by Houssein Djirdeh:
# https://docs.google.com/spreadsheets/d/1Td-4qFjuBzxp8af_if5iBC0Lkqm_OROb7_2OcbxrU_g/edit?resourcekey=0-ZCfve5cngWxF0-sv5pLRzg#gid=1628564987

WITH total_third_party_usage AS (
  SELECT
    _TABLE_SUFFIX AS client,
    canonicalDomain,
    category,
    COUNT(DISTINCT pages.url) AS total_pages
  FROM
    `httparchive.summary_pages.2025_06_01_*` AS pages
  INNER JOIN (
    SELECT
      _TABLE_SUFFIX AS client,
      pageid,
      url
    FROM
      `httparchive.summary_requests.2025_06_01_*`
  ) AS requests
  ON (
    pages._TABLE_SUFFIX = requests.client AND
    pages.pageid = requests.pageid
  )
  INNER JOIN
    `httparchive.almanac.third_parties`
  ON
    NET.HOST(requests.url) = NET.HOST(domain) AND
    date = '2025-06-01' AND
    category != 'hosting'
  GROUP BY
    client,
    canonicalDomain,
    category
  HAVING
    total_pages >= 50
)

SELECT
  client,
  canonicalDomain,
  category,
  total_pages,
  blocking_pages,
  non_blocking_pages,
  blocking_pages_pct,
  non_blocking_pages_pct,
  p50_wastedMs,
  p50_total_bytes_kib
FROM (
  SELECT
    client,
    canonicalDomain,
    category,
    total_pages,
    COUNT(DISTINCT page) AS blocking_pages,
    total_pages - COUNT(DISTINCT page) AS non_blocking_pages,
    COUNT(DISTINCT page) / total_pages AS blocking_pages_pct,
    (total_pages - COUNT(DISTINCT page)) / total_pages AS non_blocking_pages_pct,
    APPROX_QUANTILES(wasted_ms, 1000)[OFFSET(500)] AS p50_wastedMs,
    APPROX_QUANTILES(total_bytes_kib, 1000)[OFFSET(500)] AS p50_total_bytes_kib,
    RANK() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS total_pages_rank
  FROM (
    SELECT
      client,
      canonicalDomain,
      domain,
      page,
      category,
      SUM(SAFE_CAST(JSON_VALUE(renderBlockingItems, '$.wastedMs') AS FLOAT64)) AS wasted_ms,
      SUM(SAFE_CAST(JSON_VALUE(renderBlockingItems, '$.totalBytes') AS FLOAT64) / 1024) AS total_bytes_kib
    FROM
      (
        SELECT
          _TABLE_SUFFIX AS client,
          url AS page,
          report
        FROM
          `httparchive.lighthouse.2025_06_01_*`
      ),
      UNNEST(JSON_QUERY_ARRAY(report, '$.audits.render-blocking-resources.details.items')) AS renderBlockingItems
    INNER JOIN
      `httparchive.almanac.third_parties`
    ON
      NET.HOST(JSON_VALUE(renderBlockingItems, '$.url')) = domain
    GROUP BY
      client,
      canonicalDomain,
      domain,
      page,
      category
  )
  INNER JOIN
    total_third_party_usage
  USING (client, canonicalDomain, category)
  GROUP BY
    client,
    canonicalDomain,
    category,
    total_pages
  HAVING
    total_pages >= 50
)
WHERE
  total_pages_rank <= 200
ORDER BY
  client,
  total_pages DESC,
  category
