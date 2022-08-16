WITH potential_jamstack_sites_with_cache AS (
  SELECT DISTINCT
    client,
    date,
    page AS url,
    rank
  FROM
    `httparchive.almanac.requests`
  WHERE
    firstHtml AND
    (
      (
        resp_age IS NOT NULL AND
        resp_age != '' AND
        safe_cast(resp_age as numeric) > 0
      )
      OR
      (
        resp_cache_control IS NOT NULL AND
        resp_cache_control != '' AND
        expAge IS NOT NULL AND
        resp_cache_control NOT LIKE 'no-store' AND
        resp_cache_control NOT LIKE 'no-cache' AND
        expAge > 0
      )
    )
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
  WHERE 
    client = 'mobile'
    AND p75_lcp <= 2400
    AND p75_cls < 0.05
)

SELECT
  url
FROM
  potential_jamstack_sites
limit 1000
