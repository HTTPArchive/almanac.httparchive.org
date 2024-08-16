#standardSQL
# Distribution of third-parties embedded in main vs. in iframes

WITH document_frameid AS (
  SELECT
    client,
    NET.HOST(page) AS page_host,
    CASE 
      WHEN is_main_document = true AND NET.HOST(page) = NET.HOST(url)
      THEN "mainframe"
      ELSE "iframe"
    END AS frame_type,
    NET.HOST(url) AS frame_host,
    JSON_EXTRACT_SCALAR(payload, "$._frame_id") AS frame_id
  FROM `httparchive.all.requests` AS requests
  WHERE
    requests.date = "2024-06-01"
    AND requests.is_root_page = true
),
combined_frame_counts AS (
    SELECT client,
    page_host,
    frame_host,
    COUNT(DISTINCT frame_id) AS num_distinct_frameids,
    COUNT(frame_id) AS num_total_frameids,
    CASE
      WHEN COUNT(DISTINCT frame_type) = 1 AND MAX(CASE WHEN frame_type = 'mainframe' THEN 1 ELSE 0 END) = 1
      THEN "mainframe-only"
      WHEN COUNT(DISTINCT frame_type) = 1 AND MAX(CASE WHEN frame_type = 'iframe' THEN 1 ELSE 0 END) = 1
      THEN "iframe-only"
      WHEN COUNT(DISTINCT frame_id) >= 2 and COUNT(DISTINCT frame_type) = 2
      THEN "both"
    END AS frame_presence,
    FROM document_frameid
    GROUP BY client, page_host, frame_host
)
SELECT
  client,
  COUNT(DISTINCT frame_host) - 1 AS distinct_third_party_count,
  COUNT(frame_host) - 1 AS total_third_party_count,
  COUNT(DISTINCT CASE WHEN frame_presence = "mainframe-only" THEN page_host ELSE NULL END) AS num_publishers_mainframe_only,
  COUNT(DISTINCT CASE WHEN frame_presence = "iframe-only" THEN page_host ELSE NULL END) AS num_publishers_iframe_only,
  COUNT(DISTINCT CASE WHEN frame_presence = "both" THEN page_host ELSE NULL END) AS num_publishers_both,
  COUNT(DISTINCT CASE WHEN frame_presence = "mainframe-only" THEN frame_host ELSE NULL END) AS distinct_mainframe_third_party_count,
  COUNT(DISTINCT CASE WHEN frame_presence = "iframe-only" THEN frame_host ELSE NULL END) AS distinct_iframe_third_party_count,
  COUNT(DISTINCT CASE WHEN frame_presence = "both" THEN frame_host ELSE NULL END) AS distinct_both_third_party_count,
  COUNT(CASE WHEN frame_presence = "mainframe-only" THEN frame_host ELSE NULL END) AS distinct_mainframe_third_party_count,
  COUNT(CASE WHEN frame_presence = "iframe-only" THEN frame_host ELSE NULL END) AS distinct_iframe_third_party_count,
  COUNT(CASE WHEN frame_presence = "both" THEN frame_host ELSE NULL END) AS distinct_both_third_party_count
FROM combined_frame_counts
GROUP BY client;
