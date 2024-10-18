#standardSQL
# Determines to what extent the top-N technology drivers are responsible for the global adoption of different security features
-- from https://stackoverflow.com/a/54835472
CREATE TEMP FUNCTION array_slice(arr ARRAY<STRING>, start INT64, finish INT64)
RETURNS ARRAY<STRING> AS (
  ARRAY(
    SELECT part FROM UNNEST(arr) part WITH OFFSET AS index
    WHERE index BETWEEN start AND finish ORDER BY index
  )
);

WITH app_headers AS (
  SELECT
    t._TABLE_SUFFIX AS client,
    headername,
    category,
    app,
    respOtherHeaders,
    t.url AS url
  FROM
    `httparchive.summary_requests.2022_06_01_*` AS r
  INNER JOIN
    `httparchive.summary_pages.2022_06_01_*` AS p
  ON
    r._TABLE_SUFFIX = p._TABLE_SUFFIX AND
    r.pageid = p.pageid
  INNER JOIN
    `httparchive.technologies.2022_06_01_*` AS t
  ON
    r._TABLE_SUFFIX = t._TABLE_SUFFIX AND
    p.url = t.url,
    UNNEST([
      'Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy',
      'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To',
      'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection'
    ]) AS headername
  WHERE
    firstHtml AND
    category IN UNNEST(['Blogs', 'CDN', 'Web frameworks', 'Programming languages', 'CMS', 'Ecommerce', 'PaaS', 'Security'])
)

SELECT
  client,
  headername,
  topN,
  ARRAY_TO_STRING(array_slice(top_apps, 0, topN - 1), ', ', 'NULL') AS topN_apps,
  COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND CONCAT(category, '_', app) IN UNNEST(array_slice(top_apps, 0, topN - 1)), url, NULL)) AS freq_in_topN,
  SAFE_DIVIDE(COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND CONCAT(category, '_', app) IN UNNEST(array_slice(top_apps, 0, topN - 1)), url, NULL)), global_freq) AS pct_overall
FROM
  app_headers
INNER JOIN (
  SELECT
    headername,
    client,
    ARRAY_AGG(CONCAT(category, '_', app) ORDER BY freq DESC) AS top_apps
  FROM (
    SELECT
      headername,
      client,
      category,
      app,
      COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')), url, NULL)) AS freq,
      SAFE_DIVIDE(COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')), url, NULL)), COUNT(DISTINCT url)) AS pct
    FROM
      app_headers
    GROUP BY
      headername,
      client,
      category,
      app
    HAVING
      pct > 0.8 AND
      freq > 1000
  )
  GROUP BY
    client,
    headername
)
USING (client, headername)
INNER JOIN (
  SELECT
    client,
    headername,
    COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')), url, NULL)) AS global_freq
  FROM
    app_headers
  GROUP BY
    client,
    headername
)
USING (client, headername),
  UNNEST(GENERATE_ARRAY(1, 10)) AS topN
GROUP BY
  client,
  topN,
  topN_apps,
  headername,
  global_freq
ORDER BY
  client,
  headername,
  topN
