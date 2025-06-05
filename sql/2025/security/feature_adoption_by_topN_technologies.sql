#standardSQL
# Section: Drivers of security mechanism adoption - Technology stack
# Question: Determines to what extent the top-N technology drivers are responsible for the global adoption of different security features
# Note: Not sure if this query makes sense
WITH app_headers AS (
  SELECT
    client,
    headername,
    category,
    t.technology AS technology,
    JSON_VALUE(r.summary, '$.respOtherHeaders') AS respOtherHeaders,
    url
  FROM
    `httparchive.all.requests` AS r
  INNER JOIN
    `httparchive.all.pages`
  USING (client, page, date, is_root_page),
    UNNEST([
      'Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Cross-Origin-Embedder-Policy', 'Cross-Origin-Opener-Policy',
      'Cross-Origin-Resource-Policy', 'Expect-CT', 'Feature-Policy', 'Permissions-Policy', 'Referrer-Policy', 'Report-To',
      'Strict-Transport-Security', 'X-Content-Type-Options', 'X-Frame-Options', 'X-XSS-Protection', 'Timing-Allow-Origin', 'Origin-Agent-Cluster'
    ]) AS headername,
    UNNEST(technologies) AS t,
    UNNEST(t.categories) AS category
  WHERE
    date = '2024-06-01' AND
    is_root_page AND
    is_main_document AND
    category IN UNNEST(['Blogs', 'CDN', 'Web frameworks', 'Programming languages', 'CMS', 'Ecommerce', 'PaaS', 'Security'])
)

SELECT
  client,
  headername,
  topN,
  ARRAY_TO_STRING(array_slice(top_apps, 0, topN - 1), ', ', 'NULL') AS topN_apps,
  COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND CONCAT(category, '_', technology) IN UNNEST(array_slice(top_apps, 0, topN - 1)), url, NULL)) AS freq_in_topN,
  SAFE_DIVIDE(COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')) AND CONCAT(category, '_', technology) IN UNNEST(array_slice(top_apps, 0, topN - 1)), url, NULL)), global_freq) AS pct_overall
FROM
  app_headers
INNER JOIN (
  SELECT
    headername,
    client,
    ARRAY_AGG(CONCAT(category, '_', technology) ORDER BY freq DESC) AS top_apps
  FROM (
    SELECT
      headername,
      client,
      category,
      technology,
      COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')), url, NULL)) AS freq,
      SAFE_DIVIDE(COUNT(DISTINCT IF(REGEXP_CONTAINS(respOtherHeaders, CONCAT('(?i)', headername, ' ')), url, NULL)), COUNT(DISTINCT url)) AS pct
    FROM
      app_headers
    GROUP BY
      headername,
      client,
      category,
      technology
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
