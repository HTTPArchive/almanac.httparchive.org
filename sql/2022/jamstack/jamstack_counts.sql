WITH jamstack_total_sites AS (
  SELECT
    client,
    date,
    COUNT(0) AS total_jamstack_sites
  FROM
    `httparchive.almanac.jamstack_sites`
  WHERE
    methodology = '2022'
  GROUP BY
    client,
    date
),

totals AS (
  SELECT
    client,
    date,
    COUNT(0) AS total_sites
  FROM
    `httparchive.almanac.requests`
  WHERE
    firstHtml
  GROUP BY
    client,
    date
)

SELECT
  client,
  date,
  total_jamstack_sites,
  total_sites,
  SAFE_DIVIDE(total_jamstack_sites, total_sites) AS total_pct
FROM
  jamstack_total_sites
JOIN
  totals
USING (client, date)
ORDER BY
  client,
  date
