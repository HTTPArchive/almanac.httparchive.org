WITH lcp AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics, '$.performance.lcp_elem_stats.url') AS url
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2023-10-01' AND
    is_root_page
),

lh AS (
  SELECT
    client,
    page,
    JSON_VALUE(unoptimized_img, '$.url') AS url,
    CAST(JSON_VALUE(unoptimized_img, '$.wastedBytes') AS INT64) / 1024 AS wasted_kbytes
  FROM
    `httparchive.all.pages`,
    UNNEST(JSON_QUERY_ARRAY(lighthouse, '$.audits.uses-optimized-images.details.items')) AS unoptimized_img
  WHERE
    date = '2023-10-01' AND
    is_root_page
),

jpgs AS (
  SELECT
    client,
    page,
    url
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2023-10-01' AND
    is_root_page AND
    JSON_VALUE(summary, '$.format') = 'jpg'
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(wasted_kbytes, 1000 RESPECT NULLS)[OFFSET(percentile * 10)] AS wasted_kbytes,
  COUNTIF(wasted_kbytes IS NOT NULL) AS pages,
  COUNT(0) AS total_pages,
  COUNTIF(wasted_kbytes IS NOT NULL) / COUNT(0) AS pct_pages
FROM
  lcp
JOIN
  jpgs
USING
  (client, page, url)
LEFT JOIN
  lh
USING
  (client, page, url),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
