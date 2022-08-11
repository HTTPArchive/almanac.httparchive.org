with cls_values as (
  SELECT  
    url,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.CumulativeLayoutShift']") as NUMERIC) as cls
  FROM `httparchive.pages.2020_06_01_mobile` 
),

cls_all as (
  select 
    round(cls,3) as cls_round
  from cls_values
  where cls is not null
  order by cls_round
)

select 
  PERCENTILE_CONT(cls_round, 0.5) OVER() AS median
from cls_all limit 1
