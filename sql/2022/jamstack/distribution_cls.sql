-- getting bucketed distribution of CLS scores to find median and other percentiles
with cls_values as (
  SELECT  
    url,
    CAST(JSON_EXTRACT(report, '$.audits.cumulative-layout-shift.numericValue') as NUMERIC) as cls
  FROM `httparchive.lighthouse.2022_07_01_mobile` 
),

cls_clean as (
  select 
    url,
    round(cls,3) as cls_round
  from cls_values
  where cls is not null
)

select 
  cls_round,
  count(distinct(url)) as urls
from cls_clean
group by cls_round
order by cls_round 