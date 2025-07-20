WITH lh AS (
  SELECT
    client,
    page,
    rank,
    CAST(JSON_VALUE(lighthouse.audits.`render-blocking-resources`.metricSavings.FCP) AS INT64) AS metricSavings_fcp
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01' AND
    is_root_page
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(metricSavings_fcp, 1000)[OFFSET(percentile * 10)] AS metricSavings_fcp
FROM
  lh,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
