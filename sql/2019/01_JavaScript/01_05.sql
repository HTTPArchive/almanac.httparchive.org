#standardSQL
# 01_05: Percent of scripts that are gzipped.
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(COUNTIF(resp_content_encoding = 'gzip') * 100 / COUNT(0), 2) AS pct_gzip
FROM
  `httparchive.summary_requests.2019_07_01_*`
WHERE
  type = 'script'
GROUP BY
  client