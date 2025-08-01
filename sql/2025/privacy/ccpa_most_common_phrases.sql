WITH pages_with_phrase AS (
  SELECT
    client,
    rank_grouping,
    page,
    COUNT(DISTINCT page) OVER (PARTITION BY client, rank_grouping) AS total_pages_with_phrase_in_rank_group,
    JSON_QUERY_ARRAY(custom_metrics, '$.privacy.ccpa_link.CCPALinkPhrases') AS ccpa_link_phrases
  FROM `httparchive.crawl.pages`, --TABLESAMPLE SYSTEM (0.01 PERCENT)
    UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
  WHERE date = '2025-07-01' AND
    is_root_page = true AND
    rank <= rank_grouping AND
    array_length(JSON_QUERY_ARRAY(custom_metrics, '$.privacy.ccpa_link.CCPALinkPhrases')) > 0
)

SELECT
  client,
  rank_grouping,
  link_phrase,
  COUNT(DISTINCT page) AS num_pages,
  COUNT(DISTINCT page) / any_value(total_pages_with_phrase_in_rank_group) AS pct_pages
FROM pages_with_phrase,
  UNNEST(ccpa_link_phrases) AS link_phrase
GROUP BY
  link_phrase,
  rank_grouping,
  client
ORDER BY
  rank_grouping,
  client,
  num_pages DESC
