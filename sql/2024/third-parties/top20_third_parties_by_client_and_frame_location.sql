#standardSQL
# Top 20 third-parties embedded in mainframe vs. in iframes

WITH document_frameid AS (
  SELECT
    client,
    NET.HOST(page) AS page_host,
    CASE
      WHEN is_main_document = true AND NET.HOST(page) = NET.HOST(url)
        THEN 'mainframe'
        ELSE 'iframe'
    END AS frame_type,
    NET.HOST(url) AS frame_host,
    JSON_EXTRACT_SCALAR(payload, '$._frame_id') AS frame_id
  FROM 
    `httparchive.all.requests` AS requests
  WHERE
    requests.date = '2024-06-01'
  AND
    requests.is_root_page = true
),
combined_frame_counts AS (
  SELECT client,
    page_host,
    frame_host,
    COUNT(DISTINCT frame_id) AS num_distinct_frameids,
    COUNT(frame_id) AS num_total_frameids,
    CASE
      WHEN COUNT(DISTINCT frame_type) = 1 AND MAX(CASE WHEN frame_type = 'mainframe' THEN 1 ELSE 0 END) = 1
        THEN 'mainframe-only'
      WHEN COUNT(DISTINCT frame_type) = 1 AND MAX(CASE WHEN frame_type = 'iframe' THEN 1 ELSE 0 END) = 1
        THEN 'iframe-only'
      WHEN COUNT(DISTINCT frame_id) >= 2 and COUNT(DISTINCT frame_type) = 2
        THEN 'both'
    END AS frame_presence,
  FROM 
    document_frameid
  GROUP BY 
    client, 
    page_host, 
    frame_host
),
grouped_data AS (
  SELECT
    client,
    frame_host,
    COUNT(DISTINCT page_host) AS total_distinct_publisher_count,
    COUNT(DISTINCT CASE WHEN frame_presence = 'mainframe-only' THEN page_host ELSE NULL END) AS num_distinct_publishers_mainframe_only,
    COUNT(DISTINCT CASE WHEN frame_presence = 'iframe-only' THEN page_host ELSE NULL END) AS num_distinct_publishers_iframe_only,
    COUNT(DISTINCT CASE WHEN frame_presence = 'both' THEN page_host ELSE NULL END) AS num_distinct_publishers_both
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
  rank_mainframe,
  num_distinct_publishers_mainframe_only,
  rank_iframe,
  num_distinct_publishers_iframe_only,
  rank_both,
  num_distinct_publishers_both,
  CASE
    WHEN rank_mainframe <= 20
      THEN 'mainframe'
    WHEN rank_iframe <= 20
      THEN 'iframe'
    WHEN rank_both <= 20
      THEN 'both'
  END AS category
FROM
  ranked_publishers
WHERE
  rank_mainframe <= 20 
OR
  rank_iframe <= 20 
OR
  rank_both <= 20
ORDER BY 
  client,
  category,
CASE category
  WHEN 'mainframe'
    THEN num_distinct_publishers_mainframe_only
  WHEN 'iframe'
    THEN num_distinct_publishers_iframe_only
  WHEN 'both'
    THEN num_distinct_publishers_both
END DESC;
