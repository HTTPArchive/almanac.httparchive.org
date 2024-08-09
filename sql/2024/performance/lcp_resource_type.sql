# TODO: LCP resource could also be a video

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
  COUNT(*) AS pages,
  SUM(COUNT(*)) OVER (PARTITION BY client) AS total,
  COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY client) AS pct
FROM
  lcp
GROUP BY
  client,
  lcp_type
ORDER BY
  pct DESC
