#standardSQL
# 08_34: Groupings of "sec-fetch-" Header(s) parsed values buckets
#   Looks like there are a few possible value groups - no data in archive
#   https://w3c.github.io/webappsec-fetch-metadata/
#
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB

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
   REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'sec-fetch-%') AS xssvals
  FROM
    `httparchive.almanac.summary_response_bodies`
)
left join unnest(xssvals) flat_xssvals   
group by flat_xssvals
)
order by pct desc
