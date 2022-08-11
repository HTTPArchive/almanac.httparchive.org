-- getting distribution of LCP times to calculate median LCP time
-- or whatever other threshold we decide looks reasonable
WITH lcp_times AS (
  SELECT
    url,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.LargestContentfulPaint']") AS NUMERIC) AS lcp_ms
  FROM `httparchive.pages.2022_06_01_desktop`
)

SELECT
  round(lcp_ms / 1000, 1) AS lcp_s,
  count(distinct(url)) AS urls
FROM lcp_times
WHERE lcp_ms IS NOT NULL
GROUP BY lcp_s
ORDER BY lcp_s
