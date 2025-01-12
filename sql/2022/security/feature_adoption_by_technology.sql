#standardSQL
# Adoption of features based on the technology that is used
WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    category,
    app,
    COUNT(url) AS total_pages_with_technology,
    COUNT(DISTINCT IF(STARTS_WITH(url, 'https'), url, NULL)) AS total_https_pages
  FROM
    `httparchive.technologies.2022_06_01_*`
  GROUP BY
    client,
    category,
    app
)

SELECT
  client,
  category,
  app,
  headername,
  total_pages_with_technology,
  total_https_pages,
  COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')), url, NULL)) AS freq,
  SAFE_DIVIDE(COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')), url, NULL)), total_pages_with_technology) AS pct,
  SAFE_DIVIDE(COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND STARTS_WITH(url, 'https'), url, NULL)), total_https_pages) AS pct_https
FROM (
  SELECT
    total_pages_with_technology,
    total_https_pages,
    t._TABLE_SUFFIX AS client,
    t.category,
    t.app,
    respOtherHeaders,
    r.urlShort AS url,
    firstHtml
  FROM
    `httparchive.summary_requests.2022_06_01_*` AS r
  INNER JOIN
    `httparchive.summary_pages.2022_06_01_*` AS p
  USING (_TABLE_SUFFIX, pageid)
  INNER JOIN
    `httparchive.technologies.2022_06_01_*` AS t
  ON
    p._TABLE_SUFFIX = t._TABLE_SUFFIX AND
    p.urlShort = t.url
  INNER JOIN
    totals
  ON
    t._TABLE_SUFFIX = totals.client AND
    t.category = totals.category AND
    t.app = totals.app
  WHERE
    firstHtml
),
  UNNEST([
    'Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy',
    'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To',
    'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection'
  ]) AS headername
GROUP BY
  client,
  category,
  app,
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
  app,
  headername
