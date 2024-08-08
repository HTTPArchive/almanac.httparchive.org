#standardSQL
# CMS popularity per geo
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
  UNION ALL
  SELECT
    'ALL' AS geo,
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    origin,
    COUNT(DISTINCT origin) OVER (PARTITION BY IF(device = 'desktop', 'desktop', 'mobile')) AS total
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    yyyymm = 202105
)

SELECT
  *
FROM (
  SELECT
    client,
    geo,
    cms,
    COUNT(0) AS pages,
    ANY_VALUE(total) AS total,
    COUNT(DISTINCT url) / ANY_VALUE(total) AS pct
  FROM (
    SELECT DISTINCT
      geo,
      client,
      CONCAT(origin, '/') AS url,
      total
    FROM
      geo_summary
  ) JOIN (
    SELECT DISTINCT
      _TABLE_SUFFIX AS client,
      category,
      app AS cms,
      url
    FROM
      `httparchive.technologies.2021_07_01_*`
    WHERE
      app IS NOT NULL AND
      category = 'CMS' AND
      app != ''
  ) USING (client, url)
  GROUP BY
    client,
    geo,
    cms
)
WHERE
  pages > 1000
ORDER BY
  pages DESC
