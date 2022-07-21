-- step 1.1: get URLs with age headers
with headers as (
  SELECT 
    url,
    JSON_EXTRACT_ARRAY(payload, '$.response.headers') as headers_array
  FROM `httparchive.requests.2022_07_01_mobile` 
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
),

-- step 1.2: filter URLs to age headers at our chosen level
age_filtered as (
  select 
    distinct(url) as url
  from non_null_ages
  where age > 86400 -- 1 day
),

-- step 2.1: get URLs with LCP times
-- step 3.2: get URLs with CLS times
lighthouse_audits as (
  SELECT  
    url,
    CAST(JSON_EXTRACT(report, '$.audits.largest-contentful-paint.numericValue') as NUMERIC) as lcp_ms,
    CAST(JSON_EXTRACT(report, '$.audits.cumulative-layout-shift.numericValue') as NUMERIC) as cls
  FROM `httparchive.lighthouse.2022_07_01_mobile` 
),

-- step 2.2 & 3.2: filter URLs with LCP and CLS at our chosen levels
cls_and_lcp_filtered as (
  select 
    distinct(url) as url
  from lighthouse_audits
  where lcp_ms > 6600
  and cls < 0.06
),

-- step 4: get performance scores
performance_scores_raw as (
  SELECT 
    url,
    CAST(JSON_EXTRACT(payload, "$['_lighthouse.Performance']") as numeric) as performance_score
  FROM `httparchive.pages.2022_07_01_mobile`
),

performance_scores as (
  select 
    url,
    round(performance_score,2) as perf_rounded
  from performance_scores_raw
  where performance_score is not null
),

performance_filtered as (
  select
    distinct(url) as url
  from performance_scores
  where perf_rounded > 0.31
),

candidates as (
  select 
    *
  from performance_filtered p
  join cls_and_lcp_filtered cl
    on p.url = cl.url
  join age_filtered a 
    on a.url = p.url
    and a.url = cl.url
)

select count(*) from candidates
