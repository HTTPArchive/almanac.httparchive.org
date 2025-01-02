#standardSQL
# Histogram of JS bytes by 3P
SELECT
  client,
  host,
  IF(kbytes < 100, FLOOR(kbytes / 5) * 5, 100) AS kbytes,
  COUNT(DISTINCT page) AS pages,
  COUNT(0) AS requests,
  SUM(COUNT(0)) OVER (PARTITION BY client, host) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, host) AS pct
FROM (
  SELECT
    client,
    page,
    IF(NET.HOST(url) IN (
      SELECT domain FROM `httparchive.almanac.third_parties` WHERE date = '2020-08-01' AND category != 'hosting'
    ), 'third party', 'first party') AS host,
    respSize / 1024 AS kbytes
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    type = 'script'
)
GROUP BY
  client,
  host,
  kbytes
ORDER BY
  kbytes,
  client,
  host
