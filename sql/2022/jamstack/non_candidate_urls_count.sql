{% set SAMPLE_MONTH = "2022-06-01" %}

-- step 2.1: get URLs and LCP times from chrome user timings
-- step 3.1: get URLs and CLS times from chrome user timings
WITH lighthouse_audits AS (
  SELECT
    url,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.LargestContentfulPaint']") AS NUMERIC) AS lcp_ms,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.CumulativeLayoutShift']") AS NUMERIC) AS cls
  FROM `httparchive.pages.{{ SAMPLE_MONTH }}`
),

-- step 2.2 & 3.2: no filter
cls_and_lcp_filtered AS (
  SELECT DISTINCT
    url AS url
  FROM lighthouse_audits
-- where lcp_ms <= 5500
-- and cls <= 0.058
),

-- step 4.1: get URLs with age headers
headers AS (
  SELECT
    url,
    JSON_EXTRACT_ARRAY(payload, '$.response.headers') AS headers_array
  FROM `httparchive.pages.{{ SAMPLE_MONTH }}`
),

flattened_headers AS (
  SELECT
    url,
    LOWER(JSON_VALUE(flattened_headers, '$.name')) AS header_name,
    JSON_VALUE(flattened_headers, '$.value') AS header_value
  FROM headers
  CROSS JOIN UNNEST(headers.headers_array) AS flattened_headers
),

non_null_ages AS (
  SELECT
    url,
    SAFE_CAST(header_value AS NUMERIC) AS age
  FROM flattened_headers
  WHERE header_name = 'age' AND
    SAFE_CAST(header_value AS NUMERIC) IS NOT NULL
),

-- step 4.2: no filter
age_filtered AS (
  SELECT DISTINCT
    url AS url
  FROM non_null_ages
-- where age > 75600 -- 21 hours
),

non_candidates AS (
  SELECT
    *
  FROM cls_and_lcp_filtered cl
  JOIN age_filtered a
  ON a.url = cl.url
)

SELECT count(0) FROM non_candidates
