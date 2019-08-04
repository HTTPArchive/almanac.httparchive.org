#standardSQL
# 08_29: Groupings of "x-content-type-options" parsed values by percentage
#   
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

select ROUND(100*(cnt/total),5) as pct, cnt, flat_contenttypes
from 
(
select
count(*) as cnt,
sum(count(*)) OVER() AS total,
flat_contenttypes
from
(
SELECT   
   REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'x-content-type-options = ([^,\r\n]*)') AS contenttypes
  FROM
    `httparchive.almanac.summary_response_bodies`
)
left join unnest(contenttypes) flat_contenttypes    
group by flat_contenttypes
)
order by pct desc
