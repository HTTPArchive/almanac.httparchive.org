-- step 1.1: get URLs and lighthouse performance scores
WITH performance_scores_raw AS (
  SELECT
    url,
    CAST(JSON_EXTRACT(payload, "$['_lighthouse.Performance']") AS NUMERIC) AS performance_score
  FROM `httparchive.pages.2022_06_01_mobile`
),

performance_scores AS (
  SELECT
    url,
    round(performance_score, 2) AS perf_rounded
  FROM performance_scores_raw
  WHERE performance_score IS NOT NULL
),

-- step 1.2: filter to perf scores equal or better than median score
performance_filtered AS (
  SELECT DISTINCT
    url AS url
  FROM performance_scores
  WHERE perf_rounded >= 0.30
),

-- step 2.1: get URLs and LCP times from chrome user timings
-- step 3.1: get URLs and CLS times from chrome user timings
lighthouse_audits AS (
  SELECT
    url,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.LargestContentfulPaint']") AS NUMERIC) AS lcp_ms,
    CAST(JSON_EXTRACT(payload, "$['_chromeUserTiming.CumulativeLayoutShift']") AS NUMERIC) AS cls
  FROM `httparchive.pages.2022_06_01_mobile`
),

-- step 2.2 & 3.2: filter URLs with LCP smaller than median and CLS smaller than median
cls_and_lcp_filtered AS (
  SELECT DISTINCT
    url AS url
  FROM lighthouse_audits
  WHERE lcp_ms <= 5500 AND
    cls <= 0.058
),

-- step 4.1: get URLs with age headers
headers AS (
  SELECT
    url,
    JSON_EXTRACT_ARRAY(payload, '$.response.headers') AS headers_array
  FROM `httparchive.requests.2022_06_01_mobile`
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

-- step 4.2: filter URLs to age headers at our chosen level
age_filtered AS (
  SELECT DISTINCT
    url AS url
  FROM non_null_ages
  WHERE age > 68400 -- 19 hours
),

candidates AS (
  SELECT
    *
  FROM performance_filtered p
  JOIN cls_and_lcp_filtered cl
  ON p.url = cl.url
  JOIN age_filtered a
  ON a.url = p.url AND
    a.url = cl.url
)

SELECT count(0) FROM candidates
