WITH jamstack_totals AS (
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
  IF(IFNULL(_cdn_provider, '') = '', 'Does not use a CDN', _cdn_provider) AS _cdn_provider,
  COUNT(0) AS num_sites,
  total_jamstack_sites AS total_sites,
  COUNT(0) / total_jamstack_sites AS pct_sites
FROM
  `httparchive.almanac.jamstack_sites`
JOIN
  jamstack_totals
USING (client)
WHERE
  date = '2022-06-01'
GROUP BY
  client,
  _cdn_provider,
  total_sites
UNION ALL
SELECT
  'All sites' AS category,
  client,
  IF(IFNULL(_cdn_provider, '') = '', 'Does not use a CDN', _cdn_provider) AS _cdn_provider,
  COUNT(0) AS num_sites,
  total_all_sites AS total_sites,
  COUNT(0) / total_all_sites AS pct_sites
FROM
  `httparchive.almanac.requests`
JOIN
  all_sites_totals
USING (client)
WHERE
  firstHTML AND
  date = '2022-06-01'
GROUP BY
  client,
  _cdn_provider,
  total_sites
ORDER BY
  category,
  client,
  pct_sites DESC,
  _cdn_provider
