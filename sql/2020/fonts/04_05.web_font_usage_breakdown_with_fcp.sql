#standardSQL
#web_font_usage_breakdown_with_fcp
SELECT
  client,
  NET.HOST(url) AS host,
  COUNT(DISTINCT page) AS pages,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct,
  APPROX_QUANTILES(fcp, 1000)[OFFSET(500)] AS median_fcp,
  APPROX_QUANTILES(lcp, 1000)[OFFSET(500)] AS median_lcp
FROM (
  SELECT
    client,
    page,
    url
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    type = 'font' AND
    NET.HOST(page) != NET.HOST(url)
  GROUP BY
    client, url,
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
  host
HAVING
  pages >= 1000
ORDER BY
  pct DESC
