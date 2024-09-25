WITH data AS (
  SELECT
    client,
    page,
    rank,
    CAST(JSON_VALUE(lighthouse, '$.audits.render-blocking-resources.metricSavings.LCP') AS INT64) AS metricSavings_lcp,
    REGEXP_EXTRACT(JSON_VALUE(custom_metrics, '$.performance.lcp_elem_stats.url'), r'([^#]*)') AS lcp_url
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(metricSavings_lcp, 1000)[OFFSET(percentile * 10)] AS metricSavings_lcp,
  lcp_type
FROM (
  SELECT
    client,
    metricSavings_lcp,
    CASE
      WHEN lcp_url = '' THEN 'text'
      ELSE 'image'
    END AS lcp_type
  FROM
    data
),
UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  lcp_type = 'text'
GROUP BY
  percentile,
  lcp_type,
  client
ORDER BY
  percentile,
  lcp_type,
  client
