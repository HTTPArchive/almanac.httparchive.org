#standardSQL
WITH apps AS (
  SELECT DISTINCT
    IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
    CAST(REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d+)_(\d+)_(\d+).*', r'\1-\2-\3') AS DATE) AS date,
    url,
    app
  FROM
    `httparchive.technologies.*`
  WHERE (_TABLE_SUFFIX LIKE '2021_07_01%' OR _TABLE_SUFFIX LIKE '2022_06_01%') AND (LOWER(category) = 'paas' OR LOWER(app) = 'vercel')
),

jamstack_totals AS (
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
)

SELECT
  client,
  date,
  app,
  COUNT(0) AS num_sites,
  total_jamstack_sites AS total_sites,
  COUNT(0) / total_jamstack_sites AS pct_sites
FROM
  `httparchive.almanac.jamstack_sites`
JOIN
  apps
USING (client, url, date)
JOIN
  jamstack_totals
USING (client, date)
GROUP BY
  client,
  app,
  date,
  total_sites
ORDER BY
  client,
  date,
  pct_sites DESC
