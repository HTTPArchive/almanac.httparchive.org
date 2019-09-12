#standardSQL
# 08_13: mixed content
SELECT
  COUNT(*) total_sites,
  COUNTIF(mixed_count > 0) mixed_content_sites,
  COUNTIF(active_mixed_count > 0) active_mixed_content_sites
FROM
(
  SELECT 
    requests.page, 
    COUNTIF(STARTS_WITH(requests.url, 'http:')) mixed_count,
    COUNTIF(STARTS_WITH(requests.url, 'http:') AND REGEXP_CONTAINS(requests.mimeType, r'javascript|css|font')) active_mixed_count
  FROM 
    `httparchive.summary_pages.2019_07_01_desktop` AS pages
  JOIN 
    `httparchive.summary_requests.2019_07_01_desktop` AS requests
  ON 
    requests.pageid = pages.pageid
  WHERE 
    STARTS_WITH(pages.url, 'https') AND
    requests.status = 200
  GROUP BY 
    requests.page
  ORDER BY
    page
)
