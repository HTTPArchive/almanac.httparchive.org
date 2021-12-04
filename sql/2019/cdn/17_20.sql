#standardSQL
# 17_20: Percentage of responses with s-maxage directive
SELECT
  _TABLE_SUFFIX AS client,
  IFNULL(NULLIF(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') AS cdn,
  COUNTIF(LOWER(resp_cache_control) LIKE "%s-maxage%") AS freq,
  COUNTIF(firstHTML AND LOWER(resp_cache_control) LIKE "%s-maxage%") AS firstHtmlFreq,
  COUNTIF(NOT firstHtml AND LOWER(resp_cache_control) LIKE "%s-maxage%") AS resourceFreq,
  COUNT(0) AS total,
  ROUND(COUNTIF(LOWER(resp_cache_control) LIKE "%s-maxage%") * 100 / COUNT(0), 2) AS pct,
  ROUND(COUNTIF(firstHtml AND LOWER(resp_cache_control) LIKE "%s-maxage%") * 100 / COUNT(0), 2) AS firstHtmlPct,
  ROUND(COUNTIF(NOT firstHtml AND LOWER(resp_cache_control) LIKE "%s-maxage%") * 100 / COUNT(0), 2) AS ResourcePct
FROM
  `httparchive.summary_requests.2019_07_01_*`
GROUP BY
  client,
  cdn
ORDER BY
  client ASC,
  freq DESC
