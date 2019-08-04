#standardSQL
# 08_29: Groupings of "x-xss-protection" parsed values by percentage
#   
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB
# 
#   break at "report=" to generalize

select ROUND(100*(cnt/total),5) as pct, cnt, flat_xssvals
from 
(
select
count(*) as cnt,
sum(count(*)) OVER() AS total,
flat_xssvals
from
(
SELECT   
   REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'x-xss-protection = (.*report=|[^,\r\n]*)') AS xssvals
  FROM
    `httparchive.almanac.summary_response_bodies`
)
left join unnest(xssvals) flat_xssvals   
group by flat_xssvals
)
order by pct desc
