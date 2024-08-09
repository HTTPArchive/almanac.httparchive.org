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
    CAST(JSON_VALUE(summary, '$.respSize') AS INT64) / 1024 AS kbytes
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page
)

SELECT
  client,
  IF(CEILING(kbytes / 100) * 100 < 1000, CAST(CEILING(kbytes / 100) * 100 AS STRING), '1000+') AS kbytes,
  COUNT(*) AS freq,
  SUM(COUNT(*)) OVER (PARTITION BY client) AS total,
  COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY client) AS pct
FROM
  pages
JOIN
  requests
USING
  (client, page, url)
GROUP BY
  client,
  kbytes
ORDER BY
  client,
  kbytes
