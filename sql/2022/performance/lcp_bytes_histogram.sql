WITH pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_VALUE(payload, '$._metadata.page_id') AS INT64) AS pageid,
    JSON_VALUE(payload, '$._performance.lcp_elem_stats.url') AS url
  FROM
    `httparchive.pages.2022_06_01_*`
),

requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid,
    url,
    respSize / 1024 AS kbytes
  FROM
    `httparchive.summary_requests.2022_06_01_*`
)

SELECT
  client,
  IF(CEILING(kbytes / 100) * 100 < 1000, CAST(CEILING(kbytes / 100) * 100 AS STRING), '1000+') AS kbytes,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  pages
JOIN
  requests
USING (client, pageid, url)
GROUP BY
  client,
  kbytes
ORDER BY
  client,
  kbytes
