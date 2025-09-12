WITH pages AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics.performance.lcp_elem_stats.url) AS url,
    CAST(JSON_VALUE(summary.TTFB) AS INT64) AS ttfb
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
),

requests AS (
  SELECT
    client,
    page,
    url,
    CAST(JSON_VALUE(payload._created) AS FLOAT64) AS lcp_req_time
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND
    is_root_page
),

delays AS (
  SELECT
    client,
    CAST(lcp_req_time - ttfb AS INT64) AS lcp_resource_load_delay
  FROM
    pages
  JOIN
    requests
  USING (client, page, url)
  WHERE
    lcp_req_time > ttfb
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(lcp_resource_load_delay, 1000)[OFFSET(percentile * 10)] AS lcp_resource_load_delay
FROM
  delays,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
