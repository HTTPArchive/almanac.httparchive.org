#standardSQL
# Robots.txt size
CREATE TEMPORARY FUNCTION getRobotsSize(payload STRING)
RETURNS FLOAT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var robots = JSON.parse($._robots_txt);
  return robots['size']/1024;
} catch (e) {
  return 0;
}
''';

SELECT
  client,
  COUNT(DISTINCT(site)) AS sites,
  SAFE_DIVIDE(COUNTIF(robots_size > 0 AND robots_size <= 100), COUNT(DISTINCT(site))) AS pct_0_100,
  SAFE_DIVIDE(COUNTIF(robots_size > 100 AND robots_size <= 200), COUNT(DISTINCT(site))) AS pct_100_200,
  SAFE_DIVIDE(COUNTIF(robots_size > 200 AND robots_size <= 300), COUNT(DISTINCT(site))) AS pct_200_300,
  SAFE_DIVIDE(COUNTIF(robots_size > 300 AND robots_size <= 400), COUNT(DISTINCT(site))) AS pct_300_400,
  SAFE_DIVIDE(COUNTIF(robots_size > 400 AND robots_size <= 500), COUNT(DISTINCT(site))) AS pct_400_500,
  SAFE_DIVIDE(COUNTIF(robots_size > 500), COUNT(DISTINCT(site))) AS pct_gt500,
  SAFE_DIVIDE(COUNTIF(robots_size = 0), COUNT(DISTINCT(site))) AS pct_missing,
  COUNTIF(robots_size > 500) AS count_gt500,
  COUNTIF(robots_size = 0) AS count_missing
FROM (
  SELECT
    client,
    page AS site,
    getRobotsSize(payload) AS robots_size
  FROM
    `httparchive.all.pages`
  WHERE date = '2024-06-01'
) -- noqa: L062
GROUP BY
  client
ORDER BY
  client DESC
