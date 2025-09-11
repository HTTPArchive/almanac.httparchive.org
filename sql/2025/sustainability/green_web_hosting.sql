# standardSQL
# What percentage of URLs are hosted on a known green web hosting provider?

WITH gwf_date AS (
  SELECT MAX(date) AS date
  FROM `httparchive.almanac.green_web_foundation`
  WHERE date <= '2025-06-01'
),

green AS (
  SELECT
    TRUE AS is_green,
    NET.HOST(url) AS host
  FROM
    `httparchive.almanac.green_web_foundation` g
  JOIN
    gwf_date d
  ON g.date = d.date
),

pages AS (
  SELECT
    client,
    rank,
    NET.HOST(root_page) AS host
  FROM
    `httparchive.crawl.pages`
  WHERE
    is_root_page = TRUE AND
    date = '2025-06-01'
)

-- Apply rank grouping
SELECT
  client,
  rank_grouping,
  CASE
    WHEN rank_grouping = 0 THEN ''
    WHEN rank_grouping = 100000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  COUNTIF(is_green) AS total_green,
  COUNT(0) AS total_sites,
  ROUND(100 * SAFE_DIVIDE(COUNTIF(is_green), COUNT(0)), 2) AS pct_green
FROM (
  -- Left join green hosting information
  SELECT
    p.client,
    p.host,
    p.rank,
    g.is_green
  FROM
    pages AS p
  LEFT JOIN
    green AS g
  ON p.host = g.host
),
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping;
