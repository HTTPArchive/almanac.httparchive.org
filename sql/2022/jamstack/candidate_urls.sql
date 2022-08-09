-- step 1.1: get URLs and lighthouse performance scores
with performance_scores_raw as (
  SELECT 
    url,
    CAST(JSON_EXTRACT(payload, "$['_lighthouse.Performance']") as numeric) as performance_score
  FROM `httparchive.pages.2022_06_01_mobile`
),

performance_scores as (
  select 
    url,
    round(performance_score,2) as perf_rounded
  from performance_scores_raw
  where performance_score is not null
),

-- step 1.2: filter to perf scores equal or better than median score
performance_filtered as (
  select
    distinct(url) as url
  from performance_scores
  where perf_rounded >= 0.30
),

-- step 2.1: get URLs and LCP times from chrome user timings
-- step 3.1: get URLs and CLS times from chrome user timings
lighthouse_audits as (
  SELECT  
    url,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.LargestContentfulPaint']") as numeric) as lcp_ms,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.CumulativeLayoutShift']") as NUMERIC) as cls
  FROM `httparchive.pages.2022_06_01_mobile`
),

-- step 2.2 & 3.2: filter URLs with LCP smaller than median and CLS smaller than median
cls_and_lcp_filtered as (
  select 
    distinct(url) as url
  from lighthouse_audits
  where lcp_ms <= 5500
  and cls <= 0.058
),

-- step 4.1: get URLs with age headers
headers as (
  SELECT 
    url,
    JSON_EXTRACT_ARRAY(payload, '$.response.headers') as headers_array
  FROM `httparchive.requests.2022_06_01_mobile` 
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

-- step 4.2: filter URLs to age headers at our chosen level
age_filtered as (
  select 
    distinct(url) as url
  from non_null_ages
  where age > 68400 -- 19 hours
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
