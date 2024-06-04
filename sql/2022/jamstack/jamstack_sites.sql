CREATE OR REPLACE TABLE `httparchive.almanac.jamstack_sites` AS (
  WITH potential_jamstack_sites AS (
    SELECT DISTINCT
      client,
      date,
      page AS url,
      rank,
      resp_age,
      resp_cache_control,
      expAge,
      _cdn_provider
    FROM
      `httparchive.almanac.requests`
    WHERE
      firstHtml AND ((
        resp_age IS NOT NULL AND
        resp_age != '' AND
        safe_cast(resp_age AS NUMERIC) > 0
      ) OR (
        resp_cache_control IS NOT NULL AND
        resp_cache_control != '' AND
        expAge IS NOT NULL AND
        resp_cache_control NOT LIKE 'no-store' AND
        resp_cache_control NOT LIKE 'no-cache' AND
        expAge > 0
      )
      )
  ),

  fast_jamstack_sites AS (
    SELECT
      s.*,
      p75_lcp,
      fast_lcp,
      avg_lcp,
      slow_lcp,
      p75_cls,
      small_cls,
      medium_cls,
      large_cls
    FROM
      potential_jamstack_sites s
    JOIN
      `chrome-ux-report.materialized.device_summary` c
    ON
      url = CONCAT(origin, '/') AND
      s.date = c.date AND ((s.client = 'mobile' AND c.device = 'phone') OR (s.client = 'desktop' AND c.device = 'desktop') OR c.device IS NULL)
    WHERE (client = 'mobile' AND p75_lcp <= 2400 AND p75_cls < 0.05) OR (client = 'desktop' AND p75_lcp <= 2000 AND p75_cls < 0.05)
  )

  -- Add with methodology of 2022, so different methodologies
  -- (including backdating those, like we've done here),
  -- can be added to this table in future, and other queries then
  -- still reused.
  SELECT
    '2022' AS methodology,
    *
  FROM
    fast_jamstack_sites
  ORDER BY
    client,
    date
)
