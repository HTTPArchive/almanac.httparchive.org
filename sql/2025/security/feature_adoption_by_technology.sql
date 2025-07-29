#standardSQL
# Section: Driveres of security mechanism - Technology stack
# Question: How are security features and used technology correlated?
# Note: Adoption of features based on the technology that is used
WITH
totals AS (
  SELECT
    client,
    category,
    t.technology AS technology,
    COUNT(page) AS total_pages_with_technology,
    COUNT(
      DISTINCT
      IF(STARTS_WITH(page, 'https'), page, NULL)
    ) AS total_https_pages
  FROM
    `httparchive.all.pages`,
    UNNEST(technologies) AS t,
    UNNEST(t.categories) AS category
  WHERE
    date = '2025-07-01' AND
    is_root_page
  GROUP BY
    client,
    category,
    technology
)

SELECT
  client,
  category,
  technology,
  headername,
  total_pages_with_technology,
  total_https_pages,
  COUNT(
    DISTINCT
    IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')), url, NULL)
  ) AS freq,
  SAFE_DIVIDE(COUNT(
    DISTINCT
    IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')), url, NULL)
  ), total_pages_with_technology) AS pct,
  SAFE_DIVIDE(COUNT(
    DISTINCT
    IF(
      REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND
      STARTS_WITH(url, 'https'), url, NULL
    )
  ), total_https_pages) AS pct_https
FROM (
  SELECT
    client,
    technologies,
    JSON_VALUE(r.summary, '$.respOtherHeaders') AS respOtherHeaders,
    url
  FROM
    `httparchive.all.requests` AS r
  INNER JOIN
    `httparchive.all.pages`
  USING (client, page, date, is_root_page)
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    is_main_document
),
  UNNEST(['Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy', 'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To', 'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection', 'Timing-Allow-Origin', 'Origin-Agent-Cluster']) AS headername,
  UNNEST(technologies) AS t,
  UNNEST(t.categories) AS category
INNER JOIN
  totals
USING (client, category, technology)
GROUP BY
  client,
  category,
  technology,
  headername,
  total_pages_with_technology,
  total_https_pages
HAVING
  total_pages_with_technology >= 1000 AND
  category IN UNNEST(['Blogs', 'CDN', 'Web frameworks', 'Programming languages', 'CMS', 'Ecommerce', 'PaaS', 'Security']) AND
  pct >= 0.50
ORDER BY
  client,
  category,
  technology,
  headername
