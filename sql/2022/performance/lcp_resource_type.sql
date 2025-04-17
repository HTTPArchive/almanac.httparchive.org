WITH lcp AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    # Parse anchors out of LCP URLs.
    REGEXP_EXTRACT(JSON_VALUE(payload, '$._performance.lcp_elem_stats.url'), r'([^#]*)') AS url
  FROM
    `httparchive.pages.2022_06_01_*`
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
