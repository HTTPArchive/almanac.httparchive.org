with lcp_only as (
  SELECT
    device as client,
    date,
    count(distinct(origin)) as urls
  FROM `chrome-ux-report.materialized.device_summary`
  WHERE
    (device = 'phone' AND p75_lcp <= 2400)
    OR
    (device = 'desktop' AND p75_lcp <= 2000)
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
  l.client,
  l.date,
  l.urls as lcp_matches,
  a.urls as all_urls,
  l.urls/a.urls as percent_match
from lcp_only l
join all_urls a
using (client,date)
order by client, date 
