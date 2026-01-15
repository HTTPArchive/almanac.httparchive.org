# Query for wasm requests and sites counts

WITH wasmRequests AS (
  SELECT
    date,
    client,
    page,
    root_page,
    url,
    REGEXP_EXTRACT(url, r'([^/]+)$') AS filename -- lowercase & extract filename between last `/` and `.` or `?`
  FROM
    `httparchive.crawl.requests`
  WHERE
    date IN ('2021-07-01', '2022-06-01', '2024-06-01', '2025-07-01') AND
    (
      (date IN ('2024-06-01', '2025-07-01') AND type = 'wasm') -- wasm type was added in Jan 2024
      OR
      (date IN ('2021-07-01', '2022-06-01') AND (JSON_VALUE(summary.mimeType) = 'application/wasm' OR JSON_VALUE(summary.ext) = 'wasm'))
    )
),

totals AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT root_page) AS total_sites,
    COUNT(DISTINCT NET.REG_DOMAIN(page)) AS total_reg_domains
  FROM
    `httparchive.crawl.requests`
  WHERE
    date IN ('2021-07-01', '2022-06-01', '2024-06-01', '2025-07-01')
  GROUP BY
    date,
    client
)

SELECT
  date,
  client,
  COUNT(0) AS total_wasm,
  COUNT(DISTINCT filename) AS unique_wasm,
  COUNT(DISTINCT root_page) AS sites,
  total_sites,
  COUNT(DISTINCT root_page) / total_sites AS pct_sites,
  COUNT(DISTINCT NET.REG_DOMAIN(page)) AS reg_domains,
  total_reg_domains,
  COUNT(DISTINCT NET.REG_DOMAIN(page)) / total_reg_domains AS pct_reg_domains
FROM
  wasmRequests
INNER JOIN
  totals
USING (date, client)
GROUP BY
  date,
  client,
  total_sites,
  total_reg_domains
ORDER BY
  date DESC,
  client
