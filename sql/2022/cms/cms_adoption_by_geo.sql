#standardSQL
# All CMS popularity per geo
WITH geo_summary AS (
  SELECT
    `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS geo,
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    origin,
    COUNT(DISTINCT origin) OVER (PARTITION BY country_code, IF(device = 'desktop', 'desktop', 'mobile')) AS total
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    # We're intentionally using May 2022 CrUX data here.
    # That's because there's a two month lag between CrUX and HA datasets.
    # Since we're only JOINing with the CrUX dataset to see which URLs
    # belong to different countries (as opposed to CWV field data)
    # it's not necessary to look at the 202206 dataset.
    yyyymm = 202204
)

SELECT
  *
FROM (
  SELECT
    client,
    geo,
    COUNT(0) AS pages,
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
      url
    FROM
      `httparchive.technologies.2022_06_01_*`
    WHERE
      category = 'CMS'
  ) USING (client, url)
  GROUP BY
    client,
    geo
)
WHERE
  pages > 1000
ORDER BY
  pages DESC
