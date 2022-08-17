#standardSQL
WITH apps AS (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url,
    app
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    LOWER(category) = 'web frameworks'
),

jamstack_totals AS (
  SELECT
    client,
    COUNT(0) AS total_jamstack_sites
  FROM
    `httparchive.almanac.jamstack_sites`
  WHERE
    methodology = '2022' AND
    date = '2022-06-01'
  GROUP BY
    client
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
  WHERE s.date = '2022-06-01'
),

all_sites_totals AS (
  SELECT
    client,
    COUNT(0) AS total_all_sites
  FROM
    total_eligible_sites
  GROUP BY
    client
)

SELECT
  'Jamstack sites' AS category,
  client,
  app,
  COUNT(0) AS num_sites,
  total_jamstack_sites AS total_sites,
  COUNT(0) / total_jamstack_sites AS pct_sites
FROM
  `httparchive.almanac.jamstack_sites`
JOIN
  apps
USING (client, url)
JOIN
  jamstack_totals
USING (client)
WHERE
  date = '2022-06-01'
GROUP BY
  client,
  app,
  total_sites
UNION ALL
SELECT
  'All sites' AS category,
  client,
  app,
  COUNT(0) AS num_sites,
  total_all_sites AS total_sites,
  COUNT(0) / total_all_sites AS pct_sites
FROM
  apps
JOIN
  all_sites_totals
USING (client)
GROUP BY
  client,
  app,
  total_sites
ORDER BY
  category,
  client,
  pct_sites DESC,
  app
