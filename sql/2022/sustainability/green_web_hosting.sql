#standardSQL
# What percentage of URLs are hosted on a known green web hosting provider?

WITH green AS (
  SELECT
    NET.HOST(url) AS host,
    TRUE AS is_green
  FROM
    `httparchive.almanac.green_web_foundation`
),

pages AS (
  SELECT
    NET.HOST(url) AS host
  FROM
    `httparchive.summary_pages.2022_06_01_mobile`
)

SELECT
  COUNTIF(is_green) / COUNT(0)
FROM
  pages
LEFT JOIN
  green
USING
  (host)
