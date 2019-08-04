
#standardSQL
# 08_29: Groupings of "x-xss-protection" parsed values by percentage
#   
#   `httparchive.almanac.summary_response_bodies` archive = 71.5GB 
#   `httparchive.summary_requests.2019_07_01_*` = 118.3 GB
# 
#   break at "report=" to generalize
# 
#
#   Within "archive" I only see 3 buckets, "null", "allow-postmessage" and "same-origin"
# I see references to "Deny", "Allow" in Safari. 


select ROUND(100*(cnt/total),5) as pct, cnt, flat_xopenpolicyvals
from 
(
select
count(*) as cnt,
sum(count(*)) OVER() AS total,
flat_xopenpolicyvals
from
(
SELECT   
   REGEXP_EXTRACT_ALL(LOWER(respOtherHeaders),r'cross-origin-opener-policy = ([^,\r\n]*)') AS xopenpolicyvals
  FROM
    `httparchive.almanac.summary_response_bodies`
)
left join unnest(xopenpolicyvals) flat_xopenpolicyvals   
group by flat_xopenpolicyvals
)
order by pct desc
