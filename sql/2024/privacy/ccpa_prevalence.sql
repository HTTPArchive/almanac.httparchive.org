with pages as (
  select client, rank_grouping, page, JSON_VALUE(custom_metrics, "$.privacy.ccpa_link.hasCCPALink") as has_ccpa_link from `httparchive.all.pages`,
--    TABLESAMPLE SYSTEM (0.0025 PERCENT)
    UNNEST ([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping WHERE date = "2024-06-01" and is_root_page = true and rank <= rank_grouping
)
select client, rank_grouping, has_ccpa_link, count(distinct page) as num_pages from pages group by has_ccpa_link, rank_grouping, client order by rank_grouping, client, has_ccpa_link