WITH pages AS (
  SELECT client, rank_grouping, page, JSON_QUERY_ARRAY(custom_metrics, '$.privacy.ccpa_link.CCPALinkPhrases') AS ccpa_link_phrases FROM `httparchive.all.pages`, -- TABLESAMPLE SYSTEM (0.01 PERCENT)
    UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping WHERE date = '2024-06-01' AND is_root_page = true AND rank <= rank_grouping
)
SELECT client, rank_grouping, link_phrase, count(DISTINCT page) AS num_pages FROM pages, unnest(ccpa_link_phrases) link_phrase GROUP BY link_phrase, rank_grouping, client ORDER BY rank_grouping, client, num_pages DESC
