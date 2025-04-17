# We are unable to track LCP for video elements: https://issues.chromium.org/issues/364860066

WITH lcp AS (
  SELECT
    client,
    page,
    # Parse anchors out of LCP URLs.
    REGEXP_EXTRACT(JSON_VALUE(custom_metrics, '$.performance.lcp_elem_stats.url'), r'([^#]*)') AS url
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
)

SELECT
  client,
  CASE
    WHEN lcp.url = '' THEN 'text'
    WHEN STARTS_WITH(lcp.url, 'data:') THEN 'inline image'
    ELSE 'image'
  END AS lcp_type,
  COUNT(0) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  lcp
GROUP BY
  client,
  lcp_type
ORDER BY
  pct DESC
