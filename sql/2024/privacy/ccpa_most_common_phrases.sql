with pages as (
  select client, rank_grouping, page, JSON_QUERY_ARRAY(custom_metrics, "$.privacy.ccpa_link.CCPALinkPhrases") as ccpa_link_phrases from `httparchive.all.pages`, -- TABLESAMPLE SYSTEM (0.01 PERCENT)
    UNNEST ([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping WHERE date = "2024-06-01" and is_root_page = true and rank <= rank_grouping
)
select client, rank_grouping, link_phrase, count(distinct page) as num_pages from pages, unnest(ccpa_link_phrases) link_phrase group by link_phrase, rank_grouping, client order by rank_grouping, client, num_pages desc