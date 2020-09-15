#standardSQL
# 06_32: Top font hosts
SELECT
  *
FROM (
  SELECT
    client,
    NET.HOST(url) AS  host,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
  FROM
    `httparchive.almanac.requests`
  WHERE
    type = 'font'
  GROUP BY
    client,
    host
  ORDER BY
    freq / total DESC)
LIMIT
  100