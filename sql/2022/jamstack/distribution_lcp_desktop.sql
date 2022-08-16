-- getting distribution of LCP times to calculate median LCP time
-- or whatever other threshold we decide looks reasonable
WITH lcp_times AS (
  SELECT
    origin AS url,
    p75_lcp AS lcp_ms
  FROM `chrome-ux-report.materialized.device_summary`
  WHERE date = '2022-06-01'
  AND device = 'desktop'
)

SELECT
  round(lcp_ms / 1000, 1) AS lcp_s,
  count(distinct(url)) AS urls
FROM lcp_times
WHERE lcp_ms IS NOT NULL
GROUP BY lcp_s
ORDER BY lcp_s
