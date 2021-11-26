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
    app as ssg_app
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    LOWER(category) = "static site generator" OR
    app = "Next.js" OR
    app = "Nuxt.js"
),

js AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    app as js_app
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
  total,
  COUNT(DISTINCT url) / total AS pct_urls
FROM
  ssg
JOIN
  js
USING (client, url)
JOIN
  totals
USING (client)
GROUP BY
  client,
  ssg_app,
  js_app,
  total
ORDER BY
  pct_urls DESC,
  client,
  ssg_app,
  js_app
