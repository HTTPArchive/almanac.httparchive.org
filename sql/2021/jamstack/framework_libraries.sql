#standardSQL
# Adoption of image formats in SSGs

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
),

ssg AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    app AS ssg_app
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    LOWER(category) = "static site generator" OR
    app = "Next.js" OR
    app = "Nuxt.js"
),

total_ssg AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS ssg_total
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    LOWER(category) = "static site generator" OR
    app = "Next.js" OR
    app = "Nuxt.js"
  GROUP BY
    _TABLE_SUFFIX
),

total_ssg_app AS (
  SELECT
    _TABLE_SUFFIX AS client,
    app AS ssg_app,
    COUNT(0) AS ssg_app_total
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    LOWER(category) = "static site generator" OR
    app = "Next.js" OR
    app = "Nuxt.js"
  GROUP BY
    _TABLE_SUFFIX,
    app
),

js AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    app AS js_app
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category IN ('JavaScript frameworks', 'JavaScript libraries')
)

SELECT
  client,
  ssg_app,
  js_app,
  COUNT(DISTINCT url) AS num_urls,
  ssg_app_total,
  COUNT(DISTINCT url) / ssg_app_total AS pct_urls_app,
  ssg_total,
  COUNT(DISTINCT url) / ssg_total AS pct_urls_ssg,
  total,
  COUNT(DISTINCT url) / total AS pct_urls_total
FROM
  ssg
JOIN
  js
USING (client, url)
JOIN
  totals
USING (client)
JOIN
  total_ssg_app
USING (client, ssg_app)
JOIN
  total_ssg
USING (client)
GROUP BY
  client,
  ssg_app,
  ssg_app_total,
  ssg_total,
  js_app,
  total
ORDER BY
  pct_urls_total DESC,
  client,
  ssg_app,
  js_app
