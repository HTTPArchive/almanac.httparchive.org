#standardSQL

# Robots txt size by size bins (size in KiB)
# Note: Main story is robots.txt over 500 KiB which is Google's limit
# This is reason that size bins were used instead of quantiles


# helper to get robots size in kibibytes (KiB)
# Note: Assumes mostly ASCII 1byte = 1character.  Size is collected by
# custom measurement as string length.
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
    _TABLE_SUFFIX AS client,
    url AS site,
    getRobotsSize(payload) AS robots_size
  FROM
    `httparchive.pages.2021_07_01_*`)
GROUP BY
  client
ORDER BY
  client DESC
