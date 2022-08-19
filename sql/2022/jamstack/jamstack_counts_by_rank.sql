WITH jamstack_sites AS (
  SELECT
    client,
    date,
    rank,
    COUNT(0) AS total_jamstack_sites
  FROM
    `httparchive.almanac.jamstack_sites`
  WHERE
    methodology = '2022'
  GROUP BY
    client,
    date,
    rank
),

totals AS (
  SELECT
    client,
    date,
    rank,
    COUNT(0) AS total_sites
  FROM
    `httparchive.almanac.requests`
  WHERE
    firstHtml
  GROUP BY
    client,
    date,
    rank
)

SELECT
  client,
  date,
  rank_grouping,
  CASE
    WHEN rank_grouping = 0 THEN ''
    WHEN rank_grouping = 10000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  SUM(total_jamstack_sites) AS total_jamstack_sites,
  SUM(total_sites) AS total_sites,
  SAFE_DIVIDE(SUM(total_jamstack_sites), SUM(total_sites)) AS total_pct
FROM
  jamstack_sites
JOIN
  totals
USING (client, date, rank),
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  date,
  rank_grouping
ORDER BY
  client,
  date,
  rank_grouping
