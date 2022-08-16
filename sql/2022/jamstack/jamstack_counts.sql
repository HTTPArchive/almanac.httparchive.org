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

-- CrUX and HA use slightly different sets of sites for the same date
-- So the total sites we're looking at is the number of sites in the join
total_eligible_sites AS (
  SELECT
    s.*,
    p75_lcp,
    p75_cls
  FROM
    (  
      SELECT DISTINCT
        client,
        date,
        page AS url,
        rank
      FROM
        `httparchive.almanac.requests`
      WHERE
        firstHtml
    ) AS s
  JOIN
    `chrome-ux-report.materialized.device_summary` AS c
  ON
    url = CONCAT(origin, '/') AND
    s.date = c.date AND
    (
      (s.client = 'mobile' AND c.device = 'phone')
      OR
      (s.client = 'desktop' AND c.device = 'desktop')
      OR
      c.device IS NULL
    )
),

totals AS (
  SELECT
    client,
    date,
    COUNT(0) AS total_sites
  FROM
    total_eligible_sites
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
