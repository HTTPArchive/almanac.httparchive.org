#standardSQL
# Counted metrics of invalid head elements in HTML

with parsed as (SELECT
  url,
  JSON_QUERY(payload, '$._valid-head.invalidHead') as invalidHead,
  JSON_EXTRACT_ARRAY(payload, '$._valid-head.invalidElements') as invalidElements,
  ARRAY_LENGTH(JSON_EXTRACT_ARRAY(payload, '$._valid-head.invalidElements')) as invalidCount,
FROM
  `httparchive.pages.2022_07_01_*`
),

counted as (
select 
  sum(invalidCount) as invalidElements,
  countif(invalidHead='true') as invalidSiteCount,
  count(*) as totalSiteCount,
  max(invalidCount) as invalidMax,
  avg(invalidCount) as invalidAvg
from parsed
)

select *, invalidSiteCount/totalSiteCount as pctInvalid from counted 