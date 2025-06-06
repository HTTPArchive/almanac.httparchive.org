#standardSQL
# Section: Content Inclusion - Iframe Sandbox/Permissions Policy
# Question: How often are the allow and sandbox attributes used on iframes? Both per page (used in at least one iframe on a page) and over all iframe elements
WITH total_iframe_count AS (
  SELECT
    client,
    date,
    SUM(SAFE_CAST(JSON_EXTRACT(custom_metrics, '$.num_iframes') AS INT64)) AS total_iframes
  FROM
    `httparchive.all.pages`
  WHERE
    (date = '2022-06-01' OR date = '2023-06-01' OR date = '2023-12-01' OR date = '2024-03-01' OR date = '2024-04-01' OR date = '2024-05-01' OR date = '2024-06-01') AND
    is_root_page
  GROUP BY client, date
)

SELECT
  client,
  date,
  total_iframes,
  COUNTIF(allow IS NOT NULL) AS freq_allow,
  COUNTIF(allow IS NOT NULL) / total_iframes AS pct_allow_frames,
  COUNTIF(sandbox IS NOT NULL) AS freq_sandbox,
  COUNTIF(sandbox IS NOT NULL) / total_iframes AS pct_sandbox_frames,
  COUNTIF(allow IS NOT NULL AND sandbox IS NOT NULL) AS freq_both_frames,
  COUNTIF(allow IS NOT NULL AND sandbox IS NOT NULL) / total_iframes AS pct_both_frames,
  COUNT(DISTINCT url) AS total_urls,
  COUNT(DISTINCT IF(allow IS NOT NULL, url, NULL)) AS allow_freq_urls,
  COUNT(DISTINCT IF(allow IS NOT NULL, url, NULL)) / COUNT(DISTINCT url) AS allow_pct_urls,
  COUNT(DISTINCT IF(sandbox IS NOT NULL, url, NULL)) AS sandbox_freq_urls,
  COUNT(DISTINCT IF(sandbox IS NOT NULL, url, NULL)) / COUNT(DISTINCT url) AS sandbox_pct_urls
FROM (
  SELECT
    client,
    date,
    url,
    JSON_EXTRACT_SCALAR(iframeAttr, '$.allow') AS allow,
    JSON_EXTRACT_SCALAR(iframeAttr, '$.sandbox') AS sandbox
  FROM (
    SELECT
      client,
      date,
      page AS url,
      JSON_EXTRACT_ARRAY(JSON_QUERY(custom_metrics, '$.security'), '$.iframe-allow-sandbox') AS iframeAttrs
    FROM
      `httparchive.all.pages`
    WHERE
      (date = '2022-06-01' OR date = '2023-06-01' OR date = '2023-12-01' OR date = '2024-03-01' OR date = '2024-04-01' OR date = '2024-05-01' OR date = '2024-06-01') AND
      is_root_page
  )
  LEFT JOIN UNNEST(iframeAttrs) AS iframeAttr
) JOIN total_iframe_count USING (client, date)
GROUP BY
  total_iframes,
  client,
  date
ORDER BY
  date,
  client
