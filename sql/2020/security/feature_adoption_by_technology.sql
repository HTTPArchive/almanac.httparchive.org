#standardSQL
# Adoption of features based on the technology that is used
SELECT
  client,
  category,
  app,
  headername,
  COUNT(DISTINCT url) AS total_pages_with_technology,
  COUNT(DISTINCT IF(STARTS_WITH(url, 'https'), url, NULL)) AS total_https_pages,
  COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')), url, NULL)) AS freq,
  SAFE_DIVIDE(COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')), url, NULL)), COUNT(DISTINCT url)) AS pct,
  SAFE_DIVIDE(COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND STARTS_WITH(url, 'https'), url, NULL)), COUNT(DISTINCT IF(STARTS_WITH(url, 'https'), url, NULL))) AS pct_https
FROM (
  SELECT
    t._TABLE_SUFFIX AS client,
    category,
    app,
    respOtherHeaders,
    r.urlShort AS url,
    firstHtml
  FROM
    `httparchive.summary_requests.2020_08_01_*` AS r
  INNER JOIN
    `httparchive.technologies.2020_08_01_*` AS t
  ON r._TABLE_SUFFIX = t._TABLE_SUFFIX AND r.urlShort = t.url
  WHERE
    firstHtml
),
UNNEST(['Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy', 'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To', 'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection']) AS headername
GROUP BY
  client,
  category,
  app,
  headername
HAVING
  total_pages_with_technology >= 1000 AND
  category IN UNNEST(['Blogs', 'CDN', 'Web frameworks', 'Programming languages', 'CMS', 'Ecommerce', 'PaaS', 'Security']) AND
  pct >= 0.50
ORDER BY
  client,
  category,
  app,
  headername
