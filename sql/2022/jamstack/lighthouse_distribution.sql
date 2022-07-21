-- getting buckets of performance scores to find median
with performance_scores as (
  SELECT 
    url,
    CAST(JSON_EXTRACT(payload, "$['_lighthouse.Performance']") as numeric) as performance_score
  FROM `httparchive.pages.2022_07_01_mobile`
)

select 
  round(performance_score,2) as perf_rounded,
  count(distinct(url)) as urls
from performance_scores
where performance_score is not null
group by perf_rounded
order by perf_rounded
