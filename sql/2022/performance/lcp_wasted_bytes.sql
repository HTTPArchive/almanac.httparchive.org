WITH pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    CAST(JSON_VALUE(payload, '$._metadata.page_id') AS INT64) AS pageid,
    JSON_VALUE(payload, '$._performance.lcp_elem_stats.url') AS url
  FROM
    `httparchive.pages.2022_06_01_*`
),

lh AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    JSON_VALUE(unoptimized_img, '$.url') AS url,
    CAST(JSON_VALUE(unoptimized_img, '$.wastedBytes') AS INT64) / 1024 AS wasted_kbytes
  FROM
    `httparchive.lighthouse.2022_06_01_*`,
    UNNEST(JSON_QUERY_ARRAY(report, '$.audits.uses-optimized-images.details.items')) AS unoptimized_img
),

jpgs AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid,
    url
  FROM
    `httparchive.summary_requests.2022_06_01_*`
  WHERE
    format = 'jpg'
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(wasted_kbytes, 1000 RESPECT NULLS)[OFFSET(percentile * 10)] AS wasted_kbytes,
  COUNTIF(wasted_kbytes IS NOT NULL) AS pages,
  COUNT(0) AS total_pages,
  COUNTIF(wasted_kbytes IS NOT NULL) / COUNT(0) AS pct_pages
FROM
  pages
JOIN
  jpgs
USING (client, pageid, url)
LEFT JOIN
  lh
USING (client, page, url),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
