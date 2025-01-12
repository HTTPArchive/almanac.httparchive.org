#standardSQL
# usage of allow and sandbox attribute of iframe elements, per page and over all iframe elements
SELECT
  client,
  COUNT(0) AS total_iframes, # Note: These are not the total number of iframes but only the number of iframes with allow/sandbox + 1 for each website without such iframes
  COUNTIF(allow IS NOT NULL) AS freq_allow,
  COUNTIF(allow IS NOT NULL) / COUNT(0) AS pct_allow_frames,
  COUNTIF(sandbox IS NOT NULL) AS freq_sandbox,
  COUNTIF(sandbox IS NOT NULL) / COUNT(0) AS pct_sandbox_frames,
  COUNTIF(allow IS NOT NULL AND sandbox IS NOT NULL) AS freq_both_frames,
  COUNTIF(allow IS NOT NULL AND sandbox IS NOT NULL) / COUNT(0) AS pct_both_frames,
  COUNT(DISTINCT url) AS total_urls,
  COUNT(DISTINCT IF(allow IS NOT NULL, url, NULL)) AS allow_freq_urls,
  COUNT(DISTINCT IF(allow IS NOT NULL, url, NULL)) / COUNT(DISTINCT url) AS allow_pct_urls,
  COUNT(DISTINCT IF(sandbox IS NOT NULL, url, NULL)) AS sandbox_freq_urls,
  COUNT(DISTINCT IF(sandbox IS NOT NULL, url, NULL)) / COUNT(DISTINCT url) AS sandbox_pct_urls
FROM (
  SELECT
    client,
    url,
    JSON_EXTRACT_SCALAR(iframeAttr, '$.allow') AS allow,
    JSON_EXTRACT_SCALAR(iframeAttr, '$.sandbox') AS sandbox
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      url,
      JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.iframe-allow-sandbox') AS iframeAttrs
    FROM
      `httparchive.pages.2021_07_01_*`
  )
  LEFT JOIN UNNEST(iframeAttrs) AS iframeAttr
)
GROUP BY
  client
ORDER BY
  client
