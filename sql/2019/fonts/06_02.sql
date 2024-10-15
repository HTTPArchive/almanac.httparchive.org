#standardSQL
# 06_02: counts the host_url of a given font
SELECT
  client,
  font_host.value AS host,
  font_host.count AS freq,
  total_requests AS total,
  ROUND(font_host.count * 100 / total_requests, 2) AS pct_requests
FROM (
  SELECT
    client,
    APPROX_TOP_COUNT(NET.HOST(url), 500) AS font_host,
    COUNT(0) AS total_requests
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    type = 'font' AND
    NET.HOST(url) != NET.HOST(page)
  GROUP BY
    client
),
  UNNEST(font_host) AS font_host
WHERE
  font_host.count > 1000
ORDER BY
  freq / total DESC
