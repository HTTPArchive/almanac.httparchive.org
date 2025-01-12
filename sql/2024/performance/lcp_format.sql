WITH pages AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics, '$.performance.lcp_elem_stats.url') AS url
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
),

requests AS (
  SELECT
    client,
    page,
    url,
    JSON_VALUE(summary, '$.format') AS format
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page
)

SELECT
  client,
  format,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  pages
JOIN
  requests
USING (client, page, url)
GROUP BY
  client,
  format
ORDER BY
  pct DESC
