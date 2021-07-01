#standardSQL
# Percent of websites with any privacy-related service, based on wappalyzer categories
# Cannot use `core_web_vitals.technologies`, as we cannot take the `OR` of websites

WITH base AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    LOGICAL_OR(category = "Cookie compliance") AS with_cookie_compliance,
    LOGICAL_OR(category = "Browser fingerprinting") AS with_browser_fingerprinting,
    LOGICAL_OR(category = "Retargeting") AS with_retargeting,
    LOGICAL_OR(category = "Geolocation") AS with_geolocation,
  FROM `httparchive.technologies.2021_08_01_*`
  GROUP BY
    client,
    url
)

SELECT
  client,
  COUNT(url) AS total_pages,
  COUNTIF(with_cookie_compliance) AS nb_websites_with_cookie_compliance,
  COUNTIF(with_cookie_compliance) / COUNT(url) AS pct_websites_with_cookie_compliance,
  COUNTIF(with_browser_fingerprinting) AS nb_websites_with_browser_fingerprinting,
  COUNTIF(with_browser_fingerprinting) / COUNT(url) AS pct_websites_with_browser_fingerprinting,
  COUNTIF(with_retargeting) AS nb_websites_with_retargeting,
  COUNTIF(with_retargeting) / COUNT(url) AS pct_websites_with_retargeting,
  COUNTIF(with_geolocation) AS nb_websites_with_geolocation,
  COUNTIF(with_geolocation) / COUNT(url) AS pct_websites_with_geolocation,
FROM
  base
GROUP BY
  client
