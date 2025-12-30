# standardSQL
# WordPress/SEO Plugin use - Count sites per plugin by is_root_page and client

WITH plugin_counts AS (
  SELECT
    t.technology AS plugin,
    p.is_root_page,
    p.client,
    COUNT(DISTINCT p.page) AS site_count
  FROM
    `httparchive.crawl.pages` AS p,
    UNNEST(p.technologies) AS t,
    UNNEST(t.categories) AS cat
  WHERE
    p.date = '2025-07-01' AND
    lower(cat) = 'seo' AND
    is_root_page
  GROUP BY
    t.technology,
    p.is_root_page,
    p.client
),

filtered_total_counts AS (
  SELECT
    is_root_page,
    client,
    SUM(site_count) AS total_filtered_sites
  FROM
    plugin_counts
  GROUP BY
    is_root_page,
    client
),

overall_total_counts AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_all_sites
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE
  GROUP BY
    client
)

SELECT
  pc.plugin,
  pc.client,
  pc.site_count,
  ftc.total_filtered_sites AS total_seo_sites,
  otc.total_all_sites,
  ROUND(SAFE_DIVIDE(pc.site_count, ftc.total_filtered_sites), 4) AS pct_of_seo_sites,
  ROUND(SAFE_DIVIDE(pc.site_count, otc.total_all_sites), 4) AS pct_of_all_sites
FROM
  plugin_counts pc
JOIN filtered_total_counts ftc ON pc.is_root_page = ftc.is_root_page AND pc.client = ftc.client
JOIN overall_total_counts otc ON pc.client = otc.client
ORDER BY
  pc.is_root_page,
  pc.client,
  pc.site_count DESC;
