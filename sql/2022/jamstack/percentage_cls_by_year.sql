with cls_only as (
  SELECT
    device as client,
    date,
    count(distinct(origin)) as urls
  FROM `chrome-ux-report.materialized.device_summary`
  WHERE
    p75_cls < 0.05
  GROUP BY
    client,
    date
),

all_urls as (
  SELECT
    device as client,
    date,
    count(distinct(origin)) as urls
  FROM `chrome-ux-report.materialized.device_summary`
  GROUP BY
    client,
    date
)

select 
  c.client,
  c.date,
  c.urls as cls_matches,
  a.urls as all_urls,
  c.urls/a.urls as percent_match
from cls_only c
join all_urls a
using (client,date)
order by client, date 
