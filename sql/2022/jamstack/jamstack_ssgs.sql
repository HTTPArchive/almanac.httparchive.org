#standardSQL
WITH apps AS (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url,
    app
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    LOWER(category) = 'static site generator' OR
    app = 'Next.js' OR
    app = 'Nuxt.js'
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

all_sites_totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_all_sites
  FROM
    `httparchive.pages.2022_06_01_*`
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
