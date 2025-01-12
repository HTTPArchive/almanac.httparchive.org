#standardSQL
# Top 20 third-parties embedded in mainframe vs. in iframes

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
  FROM `httparchive.all.requests` AS requests
  WHERE requests.date = '2024-06-01' AND requests.is_root_page = true
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

grouped_data AS (
  SELECT
    client,
    frame_host,
    COUNT(DISTINCT page_host) AS total_distinct_publisher_count,
    COUNT(DISTINCT CASE WHEN frame_presence = 'mainframe-only' AND tp_flag THEN page_host ELSE null END) AS num_distinct_publishers_mainframe_only,
    COUNT(DISTINCT CASE WHEN frame_presence = 'iframe-only' AND tp_flag THEN page_host ELSE null END) AS num_distinct_publishers_iframe_only,
    COUNT(DISTINCT CASE WHEN frame_presence = 'both' AND tp_flag THEN page_host ELSE null END) AS num_distinct_publishers_both
  FROM combined_frame_counts
  GROUP BY client, frame_host
),

ranked_publishers AS (
  SELECT
    client,
    frame_host,
    num_distinct_publishers_mainframe_only,
    num_distinct_publishers_iframe_only,
    num_distinct_publishers_both,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY num_distinct_publishers_mainframe_only DESC) AS rank_mainframe,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY num_distinct_publishers_iframe_only DESC) AS rank_iframe,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY num_distinct_publishers_both DESC) AS rank_both
  FROM grouped_data
)

SELECT
  client,
  frame_host,
  num_distinct_publishers_mainframe_only AS num_distinct_publishers,
  'mainframe' AS category
FROM ranked_publishers
WHERE rank_mainframe <= 20 AND num_distinct_publishers_mainframe_only > 0
UNION ALL
SELECT
  client,
  frame_host,
  num_distinct_publishers_iframe_only AS num_distinct_publishers,
  'iframe' AS category
FROM ranked_publishers
WHERE rank_iframe <= 20 AND num_distinct_publishers_iframe_only > 0
UNION ALL
SELECT
  client,
  frame_host,
  num_distinct_publishers_both AS num_distinct_publishers,
  'both' AS category
FROM ranked_publishers
WHERE rank_both <= 20 AND num_distinct_publishers_both > 0
ORDER BY client, category, num_distinct_publishers DESC;
