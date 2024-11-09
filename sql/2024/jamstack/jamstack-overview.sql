-- Temporary function to extract max-age from cache-control
CREATE TEMPORARY FUNCTION GET_MAX_AGE(response_headers ARRAY<STRUCT<name STRING, value STRING>>) RETURNS INT64 AS (
  SAFE_CAST(
    REGEXP_EXTRACT(
      (
        SELECT
          value
        FROM
          UNNEST(response_headers) AS header
        WHERE
          LOWER(header.name) = 'cache-control'
        LIMIT 1
      ),
      r'max-age=(\d+)'
    ) AS INT64
  )
);

-- Temporary function to check if revalidation is required
CREATE TEMPORARY FUNCTION REQUIRES_REVALIDATION(response_headers ARRAY<STRUCT<name STRING, value STRING>>) RETURNS BOOL AS (
  EXISTS(
    SELECT 1
    FROM
      UNNEST(response_headers) AS header
    WHERE
      (LOWER(header.name) = 'cache-control' AND REGEXP_CONTAINS(LOWER(header.value), r'(must-revalidate|no-cache)')) OR
      (LOWER(header.name) IN ('etag', 'last-modified', 'expires'))
  )
);

-- Temporary function to check for dynamic content via Set-Cookie
CREATE TEMPORARY FUNCTION HAS_SET_COOKIE(response_headers ARRAY<STRUCT<name STRING, value STRING>>) RETURNS BOOL AS (
  EXISTS(
    SELECT 1
    FROM UNNEST(response_headers) AS header
    WHERE LOWER(header.name) = 'set-cookie'
  )
);

-- Temporary function to check for Vary headers that indicate dynamic content
CREATE TEMPORARY FUNCTION HAS_DYNAMIC_VARY(response_headers ARRAY<STRUCT<name STRING, value STRING>>) RETURNS BOOL AS (
  EXISTS(
    SELECT 1
    FROM UNNEST(response_headers) AS header
    WHERE LOWER(header.name) = 'vary' AND REGEXP_CONTAINS(LOWER(header.value), r'(user-agent|cookie)')
  )
);

-- Temporary function to detect presence of ETag
CREATE TEMPORARY FUNCTION HAS_ETAG(response_headers ARRAY<STRUCT<name STRING, value STRING>>) RETURNS BOOL AS (
  EXISTS(
    SELECT 1
    FROM UNNEST(response_headers) AS header
    WHERE LOWER(header.name) = 'etag'
  )
);

-- Temporary function to check if the page uses https
CREATE TEMPORARY FUNCTION IS_HTTPS(url STRING) RETURNS BOOL AS (
  LOWER(SUBSTR(url, 1, 5)) = 'https'
);

-- Temporary function that checks if a CWV is good
CREATE TEMP FUNCTION IS_GOOD (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  SAFE_DIVIDE(good, (good + needs_improvement + poor)) >= 0.75
);

WITH potential_jamstack_sites AS (
  SELECT
    p.date,
    p.client,
    p.page AS url,
    IS_HTTPS(p.page) AS is_https,
    p.technologies,
    SAFE_CAST(JSON_EXTRACT_SCALAR(p.summary, '$.TTFB') AS INT64) AS ttfb,
    SAFE_CAST(JSON_EXTRACT_SCALAR(p.summary, '$.reqTotal') AS INT64) AS total_requests,
    SAFE_CAST(JSON_EXTRACT_SCALAR(p.summary, '$.bytesTotal') AS INT64) AS bytes_total,
    SAFE_CAST(JSON_EXTRACT_SCALAR(p.summary, '$.bytesJS') AS INT64) AS bytes_js,
    SAFE_CAST(JSON_EXTRACT_SCALAR(p.summary, '$.bytesCss') AS INT64) AS bytes_css,
    GET_MAX_AGE(r.response_headers) AS max_age,
    REQUIRES_REVALIDATION(r.response_headers) AS req_revalidation,

    -- Calculate SSG Score
    MAX(
      CASE
        WHEN tech.technology = 'Next.js' THEN 30
        WHEN tech.technology = 'Nuxt.js' THEN 30
        WHEN tech.technology = 'Gatsby' THEN 30
        WHEN tech.technology = 'Hugo' THEN 100
        WHEN tech.technology = 'Astro' THEN 50
        WHEN tech.technology = 'Jekyll' THEN 100
        WHEN tech.technology = 'Docusaurus' THEN 100
        WHEN tech.technology = 'Hexo' THEN 100
        WHEN tech.technology = 'VuePress' THEN 100
        WHEN tech.technology = 'Gridsome' THEN 100
        WHEN tech.technology = 'Nextra' THEN 70
        WHEN tech.technology = 'Mintlify' THEN 70
        WHEN tech.technology = 'Eleventy' THEN 100
        WHEN tech.technology = 'Scully' THEN 70
        WHEN tech.technology = 'Pelican' THEN 100
        WHEN tech.technology = 'Octopress' THEN 100
        WHEN tech.technology = 'Retype' THEN 100
        WHEN tech.technology = 'Bridgetown' THEN 100
        ELSE 0
      END
    ) AS ssg_score,

    -- Calculate PaaS Score
    MAX(CASE
      WHEN tech.technology = 'Vercel' THEN 30
      WHEN tech.technology = 'Netlify' THEN 30
      WHEN tech.technology = 'GitHub Pages' THEN 100
      WHEN tech.technology = 'Tiiny Host' THEN 100
      ELSE 0
      END) AS paas_score,

    -- Calculate TTFB_Score
    CASE
      WHEN SAFE_CAST(JSON_EXTRACT_SCALAR(p.summary, '$.TTFB') AS INT64) <= 800 THEN 50
      WHEN SAFE_CAST(JSON_EXTRACT_SCALAR(p.summary, '$.TTFB') AS INT64) > 800 AND SAFE_CAST(JSON_EXTRACT_SCALAR(p.summary, '$.TTFB') AS INT64) <= 1800 THEN 25
      ELSE 0
    END AS ttfb_score,

    -- Calculate Cache Score
    (CASE
      WHEN GET_MAX_AGE(r.response_headers) >= 604800 AND NOT REQUIRES_REVALIDATION(r.response_headers) THEN 100
      WHEN GET_MAX_AGE(r.response_headers) >= 604800 AND REQUIRES_REVALIDATION(r.response_headers) THEN 50
      ELSE 0
      END) +
    (CASE WHEN HAS_ETAG(r.response_headers) THEN 10 ELSE 0 END) AS cache_score,

    -- Penalties for dynamic content
    CASE
      WHEN HAS_SET_COOKIE(r.response_headers) THEN -10
      ELSE 0
    END + CASE WHEN HAS_DYNAMIC_VARY(r.response_headers) THEN -15 ELSE 0 END AS dynamic_penalty
  FROM
    `httparchive.all.pages` p,
    UNNEST(p.technologies) AS tech
  LEFT JOIN
    `httparchive.all.requests` r
  ON
    p.date = r.date AND p.client = r.client AND p.page = r.page
  WHERE
    p.date IN ('2022-06-01', '2023-06-01', '2024-06-01') AND
    p.client = 'mobile' AND
    p.is_root_page AND
    r.is_root_page AND
    r.is_main_document
  GROUP BY
    p.date, p.client, p.page, p.technologies, r.response_headers, p.summary
),
-- Combine all the information and calculate total_score
total_sites AS (
  SELECT
    p.date,
    p.client,
    p.url,
    p.is_https,
    p.total_requests,
    p.bytes_total,
    p.bytes_js,
    p.bytes_css,
    p.ssg_score,
    p.paas_score,
    p.ttfb_score,
    p.max_age,
    p.req_revalidation,
    p.cache_score,
    p.dynamic_penalty,
    (
      IS_GOOD(c.fast_inp, c.avg_inp, c.slow_inp) IS NOT FALSE AND
      IS_GOOD(c.fast_lcp, c.avg_lcp, c.slow_lcp) AND
      IS_GOOD(c.small_cls, c.medium_cls, c.large_cls)) AS cwv_ok,
    c.p75_lcp,
    c.p75_cls,
    c.p75_inp,

    -- Calculate Total_Score as the sum of Cache_Score, TTFB_Score, SSG_Score, and paas_score, minus dynamic penalties
    (
      p.cache_score + p.ttfb_score + p.ssg_score + p.paas_score + p.dynamic_penalty
    ) AS total_score,
    (
      CASE
        WHEN (p.cache_score + p.ttfb_score + p.ssg_score + p.paas_score + p.dynamic_penalty) >= 100 THEN 'jamstack'
        WHEN (p.cache_score + p.ttfb_score + p.ssg_score + p.paas_score + p.dynamic_penalty) >= 50 AND
          (p.cache_score + p.ttfb_score + p.ssg_score + p.paas_score + p.dynamic_penalty) < 100
          THEN 'jamstacky'
        WHEN (p.cache_score + p.ttfb_score + p.ssg_score + p.paas_score + p.dynamic_penalty) < 50 THEN 'no-jamstack'
        ELSE 'no-jamstack'
      END
    ) AS is_jamstack
  FROM
    potential_jamstack_sites p
  JOIN
    `chrome-ux-report.materialized.device_summary` c
  ON
    p.url = CONCAT(c.origin, '/') AND
    p.date = c.date AND
    (
      (p.client = 'mobile' AND c.device = 'phone') OR
      (p.client = 'desktop' AND c.device = 'desktop') OR
      c.device IS NULL
    )
)

SELECT
  date,
  client,
  is_jamstack,
  APPROX_QUANTILES(ROUND(bytes_js / 1024, 2), 1000)[OFFSET(500)] AS median_js_kb,
  APPROX_QUANTILES(ROUND(bytes_css / 1024, 2), 1000)[OFFSET(500)] AS median_css_kb,
  APPROX_QUANTILES(ROUND(bytes_total / 1024, 2), 1000)[OFFSET(500)] AS median_total_weight_kb,
  APPROX_QUANTILES(total_requests, 1000)[OFFSET(500)] AS median_requests,
  COUNTIF(cwv_ok) AS total_cwv_ok,
  COUNTIF(is_https) AS total_https,
  APPROX_QUANTILES(p75_lcp, 1000)[OFFSET(500)] AS median_lcp,
  APPROX_QUANTILES(p75_inp, 1000)[OFFSET(500)] AS median_inp,
  CAST(APPROX_QUANTILES(p75_cls, 1000)[OFFSET(500)] AS NUMERIC) AS median_cls,
  COUNT(0) AS pages
FROM
  total_sites
GROUP BY
  date,
  client,
  is_jamstack
ORDER BY
  date ASC
