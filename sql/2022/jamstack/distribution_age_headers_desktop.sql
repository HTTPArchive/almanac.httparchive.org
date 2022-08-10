-- getting ages to calculate median age (or any other percentage threshold)
-- we're using 2022-06-01 run as the baseline because values change every year
with headers as (
  SELECT 
    url,
    JSON_EXTRACT_ARRAY(payload, '$.response.headers') as headers_array
  FROM `httparchive.requests.2022_06_01_desktop` 
),

flattened_headers as (
  SELECT 
    url,
    LOWER(JSON_VALUE(flattened_headers,'$.name')) as header_name,
    JSON_VALUE(flattened_headers,'$.value') as header_value
  FROM headers
  CROSS JOIN UNNEST(headers.headers_array) AS flattened_headers
),

non_null_ages as (
  select 
    url,
    SAFE_CAST(header_value as numeric) as age 
  from flattened_headers 
  where header_name = 'age'
  and SAFE_CAST(header_value as numeric) is not null
)

select 
  round(age/3600) as age_hours,
  count(distinct(url)) as urls
from non_null_ages
group by age_hours
order by age_hours
