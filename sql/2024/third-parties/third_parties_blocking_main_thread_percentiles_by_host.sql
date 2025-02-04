#standardSQL
# Third-Party domains which block the main thread by percentile
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
  percentile,
  p50_transfer_size_kib,
  p50_blocking_time
FROM (
  SELECT
    client,
    domain,
    category,
    COUNT(DISTINCT page) AS total_pages,
    COUNTIF(blocking > 0) AS blocking_pages,
    percentile,
    APPROX_QUANTILES(transfer_size_kib, 1000)[OFFSET(percentile * 10)] AS p50_transfer_size_kib,
    APPROX_QUANTILES(blocking_time, 1000)[OFFSET(percentile * 10)] AS p50_blocking_time,
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
          `httparchive.lighthouse.2024_06_01_*`
      ),
      UNNEST(JSON_QUERY_ARRAY(report, '$.audits.third-party-summary.details.items')) AS third_party_items
    GROUP BY
      client,
      domain,
      page,
      category
  ),
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
  GROUP BY
    client,
    domain,
    category,
    percentile
  HAVING
    total_pages >= 50
)
WHERE
  total_pages_rank <= 200
ORDER BY
  client,
  total_pages DESC,
  category,
  percentile
