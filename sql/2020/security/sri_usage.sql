#standardSQL
# Subresource integrity: number of pages that use SRI (per tagname), and tagname usage for all SRI elements
SELECT
  client,
  COUNTIF(sri IS NOT NULL) AS total_sris,
  COUNT(DISTINCT url) AS total_urls,
  COUNT(DISTINCT IF(sri IS NOT NULL, url, NULL)) AS freq,
  COUNT(DISTINCT IF(sri IS NOT NULL, url, NULL)) / COUNT(DISTINCT url) AS pct,
  COUNTIF(JSON_EXTRACT_SCALAR(sri, '$.tagname') = 'script') AS freq_script_sris,
  COUNTIF(JSON_EXTRACT_SCALAR(sri, '$.tagname') = 'script') / COUNTIF(sri IS NOT NULL) AS pct_script_sris,
  COUNTIF(JSON_EXTRACT_SCALAR(sri, '$.tagname') = 'link') AS freq_link_sris,
  COUNTIF(JSON_EXTRACT_SCALAR(sri, '$.tagname') = 'link') / COUNTIF(sri IS NOT NULL) AS pct_link_sris,
  COUNT(DISTINCT IF(JSON_EXTRACT_SCALAR(sri, '$.tagname') = 'script', url, NULL)) AS freq_script_urls,
  COUNT(DISTINCT IF(JSON_EXTRACT_SCALAR(sri, '$.tagname') = 'script', url, NULL)) / COUNT(DISTINCT url) AS pct_script_urls,
  COUNT(DISTINCT IF(JSON_EXTRACT_SCALAR(sri, '$.tagname') = 'link', url, NULL)) AS freq_link_urls,
  COUNT(DISTINCT IF(JSON_EXTRACT_SCALAR(sri, '$.tagname') = 'link', url, NULL)) / COUNT(DISTINCT url) AS pct_link_urls
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), "$.sri-integrity") AS sris
  FROM
    `httparchive.pages.2020_08_01_*`)
LEFT JOIN UNNEST(sris) AS sri
GROUP BY
  client
ORDER BY
  client,
  pct DESC
