#standardSQL

# Robots txt size by size bins (size in KiB)
# Note: Main story is robots.txt over 500 KiB which is Google's limit
# This is reason that size bins were used instead of quantiles


# helper to get robots size in kibibytes (KiB)
# Note: Assumes mostly ASCII 1byte = 1character.  Size is collected by
# custom measurement as string length.
CREATE TEMPORARY FUNCTION getRobotsSize(custom_metrics_json JSON)
RETURNS FLOAT64 LANGUAGE js AS '''
try {
  // NOTE: custom_metrics_json is already a JS object (no JSON.parse needed)
  var cm = custom_metrics_json;
  var robots = cm && cm.robots_txt;
  return robots && robots.size ? robots.size/1024 : 0;
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
    client AS client,
    page AS site,
    getRobotsSize(TO_JSON(custom_metrics)) AS robots_size
  FROM
    `httparchive.crawl.pages`
  WHERE
    DATE = '2025-06-01'
)
GROUP BY
  client
ORDER BY
  client DESC
