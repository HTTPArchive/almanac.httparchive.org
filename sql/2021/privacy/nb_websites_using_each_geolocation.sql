#standardSQL
# Percent of websites using a geolocation library (Based on wappalyzer 'Geolocation' category)
# Alternatively, `core_web_vitals.technologies` could be used, but then we do not have
#  access to the total number of websites

WITH apps AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    IF(category = "Geolocation", app, "") AS geolocation_app
  FROM `httparchive.technologies.2021_07_01_*`
  GROUP BY
    client,
    url,
    geolocation_app
),

base AS (
  SELECT
    client,
    url,
    geolocation_app,
    COUNT(DISTINCT url) OVER (PARTITION BY client) AS total_pages,
    COUNT(DISTINCT url) / COUNT(DISTINCT url) OVER (PARTITION BY client) AS pct_pages_with_geolocation
  FROM
    apps
  GROUP BY
    client,
    url,
    geolocation_app
)

SELECT
  client,
  geolocation_app,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT url) / ANY_VALUE(total_pages) AS pct_pages_with_geolocation
FROM
  base
WHERE
  geolocation_app != ""
GROUP BY
  client,
  geolocation_app
ORDER BY
  client ASC,
  total_pages DESC
