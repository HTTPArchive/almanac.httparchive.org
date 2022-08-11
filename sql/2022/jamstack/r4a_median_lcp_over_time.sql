with lcp_times as (
  SELECT 
    url,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.LargestContentfulPaint']") as numeric) as lcp_ms
  FROM `httparchive.pages.2020_06_01_desktop`
),

all_lcp as (
  select 
    round(lcp_ms/1000,1) as lcp_s
  from lcp_times 
  where lcp_ms is not null
  order by lcp_s 
)

SELECT
  PERCENTILE_CONT(lcp_s, 0.5 RESPECT NULLS) OVER() AS median
FROM all_lcp limit 1;
