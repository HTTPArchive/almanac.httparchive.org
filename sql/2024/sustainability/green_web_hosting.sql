# standardSQL
# What percentage of URLs are hosted on a known green web hosting provider?

WITH green AS (
  SELECT
    NET.HOST(url) AS host,
    TRUE AS is_green
  FROM
    `httparchive.almanac.green_web_foundation`
  WHERE
    date = '2024-09-01'
),

pages AS (
  SELECT
    client,
    NET.HOST(root_page) AS host,
    rank
  FROM
    `httparchive.all.pages`
  WHERE
    is_root_page = TRUE AND
    date = '2024-06-01'
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
  SAFE_DIVIDE(COUNTIF(is_green), COUNT(0)) AS pct_green
FROM (
  -- Left join green hosting information
  SELECT
    p.client,
    p.host,
    p.rank,
    g.is_green
  FROM
    pages p
  LEFT JOIN
    green g
  USING
    (host)
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
