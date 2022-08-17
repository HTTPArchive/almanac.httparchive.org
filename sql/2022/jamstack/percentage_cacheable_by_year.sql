with cacheable as (
    SELECT 
      client,
      date,
      count(distinct(url)) as urls
    FROM
        `httparchive.almanac.requests`
    WHERE
        firstHtml AND
        (
            (
                resp_age IS NOT NULL AND
                resp_age != '' AND
                safe_cast(resp_age AS NUMERIC) > 0
            )
            OR
            (
                resp_cache_control IS NOT NULL AND
                resp_cache_control != '' AND
                expAge IS NOT NULL AND
                resp_cache_control NOT LIKE 'no-store' AND
                resp_cache_control NOT LIKE 'no-cache' AND
                expAge > 0
            )
        )
    GROUP BY 
      client,
      date
),

all_sites as (
    SELECT
        client,
        date,
        count(distinct(url)) as urls
    FROM
        `httparchive.almanac.requests`
    WHERE
        firstHtml
    GROUP BY
      client,
      date
)

select 
  c.client,
  c.date,
  c.urls as cacheable,
  a.urls as all_urls,
  c.urls/a.urls as percent_cacheable
from cacheable c 
join all_sites a
using (client,date)
order by 
  client,
  date
