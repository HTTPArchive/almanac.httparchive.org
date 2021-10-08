#standardSQL

# Robots txt size by size bins (size in KiB)

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
  COUNTIF(robots_sizes <= 100) / COUNT(0) AS pct_0_100,
  COUNTIF(robots_sizes > 100 AND robots_sizes <= 200) / COUNT(0) AS pct_100_200,
  COUNTIF(robots_sizes > 200 AND robots_sizes <= 300) / COUNT(0) AS pct_200_300,
  COUNTIF(robots_sizes > 300 AND robots_sizes <= 400) / COUNT(0) AS pct_300_400,
  COUNTIF(robots_sizes > 400 AND robots_sizes <= 500) / COUNT(0) AS pct_400_500,
  COUNTIF(robots_sizes > 500) / COUNT(0) AS pct_gt500,
  COUNTIF(robots_sizes > 500) AS count_gt500
FROM (
  SELECT
    _TABLE_SUFFIX,
    getRobotsSize(payload) AS robots_sizes
  FROM
    `httparchive.pages.2021_07_01_*`
  WHERE _TABLE_SUFFIX = 'desktop')
