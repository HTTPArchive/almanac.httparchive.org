# standardSQL
# WordPress/SEO Plugin use - Count sites per plugin by is_root_page and client

WITH plugin_counts AS (
  SELECT
    t.technology AS plugin,
    p.is_root_page,
    p.client,
    COUNT(DISTINCT p.page) AS site_count
  FROM `httparchive.crawl.pages` AS p
  TABLESAMPLE SYSTEM (1 PERCENT),
  UNNEST(p.technologies) AS t,
  UNNEST(t.categories) AS cat
  WHERE
    p.date = '2025-07-01'
    AND cat IN ('seo', 'SEO')
    AND is_root_page = TRUE
  GROUP BY
    t.technology,
    p.is_root_page,
    p.client
),
total_counts AS (
  SELECT
    is_root_page,
    client,
    SUM(site_count) AS total_sites
  FROM plugin_counts
  GROUP BY
    is_root_page,
    client
)
SELECT
  pc.plugin,
  pc.is_root_page,
  pc.client,
  pc.site_count,
  ROUND(SAFE_DIVIDE(pc.site_count, tc.total_sites), 4) AS pct
FROM plugin_counts pc
JOIN total_counts tc
  ON pc.is_root_page = tc.is_root_page
  AND pc.client = tc.client
ORDER BY
  pc.is_root_page,
  pc.client,
  pc.site_count DESC;
