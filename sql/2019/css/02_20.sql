#standardSQL
# 02_20: Top 100 stylesheet names
SELECT
  client,
  filename,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    ARRAY_REVERSE(SPLIT(url, '/'))[OFFSET(0)] AS filename
  FROM
    `httparchive.summary_requests.2019_07_01_*`
  WHERE
    type = 'css')
GROUP BY
  client,
  filename
ORDER BY
  freq / total DESC
LIMIT 100
