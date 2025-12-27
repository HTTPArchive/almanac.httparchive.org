WITH pages AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics.performance.lcp_elem_stats.url) AS url
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
    CAST(JSON_VALUE(summary.respSize) AS INT64) / 1024 AS kbytes
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND
    is_root_page
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(kbytes, 1000)[OFFSET(percentile * 10)] AS kbytes
FROM
  pages
JOIN
  requests
USING (client, page, url),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
