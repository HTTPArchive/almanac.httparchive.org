#standardSQL
# All SSG popularity per geo
WITH geo_summary AS (
  SELECT
    `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS geo,
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    origin,
    COUNT(DISTINCT origin) OVER (PARTITION BY country_code, IF(device = 'desktop', 'desktop', 'mobile')) AS total
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    # We're intentionally using May 2021 CrUX data here.
    # That's because there's a two month lag between CrUX and HA datasets.
    # Since we're only JOINing with the CrUX dataset to see which URLs
    # belong to different countries (as opposed to CWV field data)
    # it's not necessary to look at the 202107 dataset.
    yyyymm = 202105
)

SELECT
  *
FROM (
  SELECT
    app,
    client,
    geo,
    COUNT(0) AS pages,
    COUNT(DISTINCT url) AS origins,
    ANY_VALUE(total) AS total,
    COUNT(0) / ANY_VALUE(total) AS pct
  FROM (
    SELECT DISTINCT
      geo,
      client,
      total,
      CONCAT(origin, '/') AS url
    FROM
      geo_summary
  ) JOIN (
    SELECT DISTINCT
      _TABLE_SUFFIX AS client,
      app,
      url
    FROM
      `httparchive.technologies.2021_07_01_*`
    WHERE
      LOWER(category) = "static site generator" OR
      app = "Next.js" OR
      app = "Nuxt.js"
  ) USING (client, url)
  GROUP BY
    app,
    client,
    geo
  ORDER BY
    origins DESC)
