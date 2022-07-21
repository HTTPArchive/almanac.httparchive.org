-- getting distribution of LCP times to calculate median LCP time
-- or whatever other threshold we decide looks reasonable
with lcp_times as (
  SELECT  
    url,
    CAST(JSON_EXTRACT(report, '$.audits.largest-contentful-paint.numericValue') as NUMERIC) as lcp_ms
  FROM `httparchive.lighthouse.2022_07_01_mobile` 
)

select 
  round(lcp_ms/1000,1) as lcp_s,
  count(distinct(url))
from lcp_times 
where lcp_ms is not null
group by lcp_s
order by lcp_s 
