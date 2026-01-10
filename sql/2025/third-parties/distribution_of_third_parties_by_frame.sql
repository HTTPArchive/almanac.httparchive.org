#standardSQL
# Distribution of third-parties embedded in main vs. in iframes

WITH document_frameid AS (
  SELECT
    client,
    NET.HOST(page) AS page_host,
    NET.HOST(url) AS frame_host,
    CASE
      WHEN is_main_document = true
        THEN JSON_EXTRACT_SCALAR(payload, '$._frame_id')
    END AS mainframe_id,
    JSON_EXTRACT_SCALAR(payload, '$._frame_id') AS frame_id,
    is_main_document
  FROM `httparchive.crawl.requests` AS requests
  WHERE requests.date = '2025-07-01' AND requests.is_root_page = true
),

page_frames AS (
  SELECT
    client,
    page_host,
    frame_host,
    CASE
      WHEN frame_host != page_host
        THEN true
      ELSE false
    END AS tp_flag,
    is_main_document,
    frame_id,
    COALESCE(mainframe_id, FIRST_VALUE(mainframe_id) OVER (PARTITION BY page_host ORDER BY is_main_document DESC)) AS mainframe_id,
    CASE
      WHEN frame_id = COALESCE(mainframe_id, FIRST_VALUE(mainframe_id) OVER (PARTITION BY page_host ORDER BY is_main_document DESC))
        THEN 'mainframe'
      ELSE 'iframe'
    END AS frame_type
  FROM document_frameid
),

combined_frame_counts AS (
  SELECT
    client,
    page_host,
    frame_host,
    tp_flag,
    CASE
      WHEN COUNT(DISTINCT frame_type) = 1 AND MAX(CASE WHEN frame_type = 'mainframe' THEN 1 ELSE 0 END) = 1
        THEN 'mainframe-only'
      WHEN COUNT(DISTINCT frame_type) = 1 AND MAX(CASE WHEN frame_type = 'iframe' THEN 1 ELSE 0 END) = 1
        THEN 'iframe-only'
      WHEN COUNT(DISTINCT frame_id) >= 2 AND COUNT(DISTINCT frame_type) = 2
        THEN 'both'
    END AS frame_presence
  FROM page_frames
  GROUP BY client, page_host, frame_host, tp_flag
),

aggregated_counts AS (
  SELECT
    client,
    COUNT(DISTINCT page_host) AS distinct_publisher_count,
    COUNT(DISTINCT CASE WHEN tp_flag THEN frame_host ELSE null END) AS distinct_third_party_count,
    COUNT(DISTINCT CASE WHEN frame_presence = 'mainframe-only' AND tp_flag THEN page_host ELSE null END) AS distinct_publishers_mainframe_only,
    COUNT(DISTINCT CASE WHEN frame_presence = 'iframe-only' AND tp_flag THEN page_host ELSE null END) AS distinct_publishers_iframe_only,
    COUNT(DISTINCT CASE WHEN frame_presence = 'both' AND tp_flag THEN page_host ELSE null END) AS distinct_publishers_both,
    COUNT(DISTINCT CASE WHEN frame_presence = 'mainframe-only' AND tp_flag THEN frame_host ELSE null END) AS distinct_mainframe_third_party_count,
    COUNT(DISTINCT CASE WHEN frame_presence = 'iframe-only' AND tp_flag THEN frame_host ELSE null END) AS distinct_iframe_third_party_count,
    COUNT(DISTINCT CASE WHEN frame_presence = 'both' AND tp_flag THEN frame_host ELSE null END) AS distinct_both_third_party_count
  FROM combined_frame_counts
  GROUP BY client
)

SELECT
  client,
  distinct_publisher_count,
  distinct_third_party_count,
  distinct_publishers_mainframe_only,
  distinct_publishers_iframe_only,
  distinct_publishers_both,
  distinct_mainframe_third_party_count,
  distinct_mainframe_third_party_count / distinct_third_party_count AS pct_tps_in_mainframe_only,
  distinct_iframe_third_party_count,
  distinct_iframe_third_party_count / distinct_third_party_count AS pct_tps_in_iframe_only,
  distinct_both_third_party_count,
  distinct_both_third_party_count / distinct_third_party_count AS pct_tps_in_both
FROM aggregated_counts;
