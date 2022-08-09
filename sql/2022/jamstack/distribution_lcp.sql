-- getting distribution of LCP times to calculate median LCP time
-- or whatever other threshold we decide looks reasonable
with lcp_times as (
  SELECT 
    url,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.LargestContentfulPaint']") as numeric) as lcp_ms
  FROM `httparchive.pages.2022_06_01_mobile`
)

select 
  round(lcp_ms/1000,1) as lcp_s,
  count(distinct(url))
from lcp_times 
where lcp_ms is not null
group by lcp_s
order by lcp_s 
