#standardSQL
# What percentage of URLs are hosted on a known green web hosting provider?

WITH green AS (
  SELECT
    NET.HOST(url) AS host,
    TRUE AS is_green
  FROM
    `httparchive.almanac.green_web_foundation`
  WHERE
    date = '2022-06-01'
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    NET.HOST(url) AS host,
    rank
  FROM
    `httparchive.summary_pages.2022_06_01_*`
)

SELECT
  client,
  rank_grouping,
  CASE
    WHEN rank_grouping = 0 THEN ''
    WHEN rank_grouping = 10000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  COUNTIF(is_green) AS total_green,
  COUNT(0) AS total_sites,
  COUNTIF(is_green) / COUNT(0) AS pct_green
FROM
  pages
LEFT JOIN
  green
USING (host),
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping
