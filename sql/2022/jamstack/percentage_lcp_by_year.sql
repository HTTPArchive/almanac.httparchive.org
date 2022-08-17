WITH lcp_only AS (
  SELECT
    device AS client,
    date,
    COUNT(DISTINCT(origin)) AS urls
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    (device = 'phone' AND p75_lcp <= 2400)
    OR
    (device = 'desktop' AND p75_lcp <= 2000)
  GROUP BY
    client,
    date
),

all_urls AS (
  SELECT
    device AS client,
    date,
    COUNT(DISTINCT(origin)) AS urls
  FROM
    `chrome-ux-report.materialized.device_summary`
  GROUP BY
    client,
    date
)

SELECT
  l.client,
  l.date,
  l.urls AS lcp_matches,
  a.urls AS all_urls,
  l.urls / a.urls AS percent_match
FROM
  lcp_only l
JOIN
  all_urls a
USING (client, date)
ORDER BY
  client,
  date
