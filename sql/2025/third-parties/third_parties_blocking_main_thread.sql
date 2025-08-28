#standardSQL
# Third-Party domains which block the main thread
#
# As Lighthouse measures all impact there is no need to do a separate total
# Lighthouse also gives a useable category. So no need to use almanac.third-parties table
#
# Based heavily on research by Houssein Djirdeh:
# https://docs.google.com/spreadsheets/d/1Td-4qFjuBzxp8af_if5iBC0Lkqm_OROb7_2OcbxrU_g/edit?resourcekey=0-ZCfve5cngWxF0-sv5pLRzg#gid=1628564987

SELECT
  client,
  domain,
  category,
  total_pages,
  blocking_pages,
  non_blocking_pages,
  pct_blocking_pages,
  pct_non_blocking_pages,
  p50_transfer_size_kib,
  p50_blocking_time,
  total_pages_rank
FROM (
  SELECT
    client,
    domain,
    category,
    COUNT(DISTINCT page) AS total_pages,
    COUNTIF(blocking > 0) AS blocking_pages,
    COUNT(DISTINCT page) - COUNTIF(blocking > 0) AS non_blocking_pages,
    COUNTIF(blocking > 0) / COUNT(0) AS pct_blocking_pages,
    (COUNT(DISTINCT page) - COUNTIF(blocking > 0)) / COUNT(0) AS pct_non_blocking_pages,
    APPROX_QUANTILES(transfer_size_kib, 1000)[OFFSET(500)] AS p50_transfer_size_kib,
    APPROX_QUANTILES(blocking_time, 1000)[OFFSET(500)] AS p50_blocking_time,
    RANK() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS total_pages_rank
  FROM (
    SELECT
      client,
      JSON_VALUE(third_party_items, '$.entity.url') AS domain,
      page,
      JSON_VALUE(third_party_items, '$.entity.text') AS category,
      COUNTIF(SAFE_CAST(JSON_VALUE(report, '$.audits.third-party-summary.details.summary.wastedMs') AS FLOAT64) > 250) AS blocking,
      SUM(SAFE_CAST(JSON_VALUE(third_party_items, '$.blockingTime') AS FLOAT64)) AS blocking_time,
      SUM(SAFE_CAST(JSON_VALUE(third_party_items, '$.transferSize') AS FLOAT64) / 1024) AS transfer_size_kib
    FROM
      (
        SELECT
          _TABLE_SUFFIX AS client,
          url AS page,
          report
        FROM
          `httparchive.lighthouse.2025_06_01_*`
      ),
      UNNEST(JSON_QUERY_ARRAY(report, '$.audits.third-party-summary.details.items')) AS third_party_items
    GROUP BY
      client,
      domain,
      page,
      category
  )
  GROUP BY
    client,
    domain,
    category
  HAVING
    total_pages >= 50
)
WHERE
  total_pages_rank <= 200
ORDER BY
  client,
  total_pages DESC
