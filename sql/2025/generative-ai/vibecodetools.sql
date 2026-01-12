#standardSQL
WITH base AS (
  SELECT
    date,
    page,
    NET.HOST(page) AS host
  FROM
    `httparchive.crawl.pages`
  WHERE
    client = 'desktop' AND
    is_root_page AND
    date IN (
      '2020-01-01', '2020-04-01', '2020-07-01', '2020-10-01', -- noqa: CV09
      '2021-01-01', '2021-04-01', '2021-07-01', '2021-10-01',
      '2022-01-01', '2022-04-01', '2022-07-01', '2022-10-01', -- noqa: CV09
      '2023-01-01', '2023-04-01', '2023-07-01', '2023-10-01',
      '2024-01-01', '2024-04-01', '2024-07-01', '2024-10-01', -- noqa: CV09
      '2025-01-01', '2025-04-01', '2025-07-01', '2025-10-01'
    )
),

classified AS (
  SELECT
    date,
    page,
    CASE
      WHEN ENDS_WITH(host, '.vercel.app') THEN 'vercel'
      WHEN ENDS_WITH(host, '.pages.dev') THEN 'cloudflare_pages'
      WHEN ENDS_WITH(host, '.workers.dev') THEN 'cloudflare_workers'
      WHEN ENDS_WITH(host, '.lovable.app') OR ENDS_WITH(host, 'lovable.dev') THEN 'lovable'
      WHEN ENDS_WITH(host, '.bolt.new') OR ENDS_WITH(host, 'stackblitz.io') THEN 'bolt'
      WHEN ENDS_WITH(host, '.v0.dev') THEN 'v0'
      WHEN ENDS_WITH(host, '.replit.app') THEN 'replit'
      ELSE NULL
    END AS platform
  FROM
    base
),

totals AS (
  SELECT
    date,
    COUNT(0) AS total_pages
  FROM
    base
  GROUP BY
    date
)

SELECT
  c.date,
  c.platform,
  COUNT(0) AS pages,
  SAFE_DIVIDE(COUNT(0), t.total_pages) AS pct_pages
FROM
  classified c
JOIN
  totals t
USING (date)
WHERE
  c.platform IS NOT NULL
GROUP BY
  c.date,
  c.platform,
  t.total_pages
ORDER BY
  c.date,
  pct_pages DESC;
