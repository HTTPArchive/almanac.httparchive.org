#standardSQL
# 01_06: Percent of scripts that are brotli encoded.
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(COUNTIF(resp_content_encoding = 'br') * 100 / COUNT(0), 2) AS pct_brotli
FROM
  `httparchive.summary_requests.2019_07_01_*`
WHERE
  type = 'script'
GROUP BY
  client