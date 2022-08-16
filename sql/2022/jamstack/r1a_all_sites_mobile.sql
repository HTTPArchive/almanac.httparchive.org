WITH potential_jamstack_sites_with_cache AS (
  SELECT DISTINCT
    client,
    date,
    page AS url,
    rank
  FROM
    `httparchive.almanac.requests`
  WHERE
    firstHtml
),

potential_jamstack_sites AS (
  SELECT
    s.*,
    p75_lcp,
    p75_cls
  FROM
    potential_jamstack_sites_with_cache s
  JOIN
    `chrome-ux-report.materialized.device_summary` c
  ON
    url = CONCAT(origin, '/') AND
    s.date = c.date AND
    (
      (s.client = 'mobile' AND c.device = 'phone')
      OR
      (s.client = 'desktop' AND c.device = 'desktop')
    )
)

SELECT
  date,
  count(*)
FROM
  potential_jamstack_sites
WHERE 
  client = 'mobile'
GROUP BY 
  date
ORDER BY
  date
