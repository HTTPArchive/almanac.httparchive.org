WITH lcp_times AS (
  SELECT
    url,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.LargestContentfulPaint']") AS NUMERIC) AS lcp_ms
  FROM `httparchive.pages.2020_06_01_desktop`
),

all_lcp AS (
  SELECT
    round(lcp_ms / 1000, 1) AS lcp_s
  FROM lcp_times
  WHERE lcp_ms IS NOT NULL
  ORDER BY lcp_s
)

SELECT
  PERCENTILE_CONT(lcp_s, 0.5 RESPECT NULLS) OVER() AS median
FROM all_lcp LIMIT 1;
