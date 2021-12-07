#standardSQL
#self_hosted_vs_hosted_with_fcp
SELECT
  client,
  CASE
    WHEN pct_self_hosted_hosted = 1 THEN 'self-hosted'
    WHEN pct_self_hosted_hosted = 0 THEN 'external'
    ELSE 'both' END
  AS font_host,
  COUNT(DISTINCT page) AS pages,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct,
  APPROX_QUANTILES(fcp, 1000)[OFFSET(500)] AS median_fcp,
  APPROX_QUANTILES(lcp, 1000)[OFFSET(500)] AS median_lcp
FROM (
  SELECT
    client,
    page,
    COUNTIF(NET.HOST(page) = NET.HOST(url)) / COUNT(0) AS pct_self_hosted_hosted
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    type = 'font'
  GROUP BY
    client,
    page)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    CAST(JSON_EXTRACT_SCALAR(payload, "$['_chromeUserTiming.firstContentfulPaint']") AS INT64) AS fcp,
    CAST(JSON_EXTRACT_SCALAR(payload, "$['_chromeUserTiming.LargestContentfulPaint']") AS INT64) AS lcp
  FROM
    `httparchive.pages.2020_08_01_*`)
USING
  (client, page)
GROUP BY
  client,
  font_host
ORDER BY
  font_host,
  client
