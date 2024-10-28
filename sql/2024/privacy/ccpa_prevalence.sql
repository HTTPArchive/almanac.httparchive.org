WITH pages AS (
  SELECT client, rank_grouping, page, JSON_VALUE(custom_metrics, '$.privacy.ccpa_link.hasCCPALink') AS has_ccpa_link FROM `httparchive.all.pages`,
    --    TABLESAMPLE SYSTEM (0.0025 PERCENT)
    UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping WHERE date = '2024-06-01' AND is_root_page = true AND rank <= rank_grouping
)
SELECT client, rank_grouping, has_ccpa_link, count(DISTINCT page) AS num_pages FROM pages GROUP BY has_ccpa_link, rank_grouping, client ORDER BY rank_grouping, client, has_ccpa_link
