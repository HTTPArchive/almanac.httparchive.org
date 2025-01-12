#standardSQL
# 08_13: mixed content
SELECT
  client,
  COUNTIF(mixed_count > 0) AS mixed_content_sites,
  COUNTIF(active_mixed_count > 0) AS active_mixed_content_sites,
  COUNT(0) AS total,
  ROUND(COUNTIF(mixed_count > 0) * 100 / COUNT(0), 2) AS pct_mixed,
  ROUND(COUNTIF(active_mixed_count > 0) * 100 / COUNT(0), 2) AS pct_active_mixed
FROM (
  SELECT
    client,
    COUNTIF(STARTS_WITH(url, 'http:')) AS mixed_count,
    COUNTIF(STARTS_WITH(url, 'http:') AND type IN ('script', 'css', 'font')) AS active_mixed_count
  FROM
    `httparchive.almanac.summary_requests`
  WHERE
    date = '2019-07-01' AND
    STARTS_WITH(page, 'https') AND
    status = 200
  GROUP BY
    client,
    page
)
GROUP BY
  client
