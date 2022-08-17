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

-- slight modification of total_eligible_sites to include _cdn_provider
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
        rank,
        _cdn_provider
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
  total_eligible_sites
JOIN
  all_sites_totals
USING (client)
GROUP BY
  client,
  _cdn_provider,
  total_sites
ORDER BY
  category,
  client,
  pct_sites DESC,
  _cdn_provider
