#standardSQL
# Percent of websites with any privacy-related service, based on wappalyzer categories
# Cannot use `core_web_vitals.technologies`, as we cannot take the `OR` of websites

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(DISTINCT url) AS total_pages,
  COUNT(DISTINCT IF(category = "Cookie compliance", url, NULL)) AS number_of_websites_with_cookie_compliance,
  COUNT(DISTINCT IF(category = "Cookie compliance", url, NULL)) / COUNT(DISTINCT url) AS pct_websites_with_cookie_compliance,
  COUNT(DISTINCT IF(category = "Browser fingerprinting", url, NULL)) AS number_of_websites_with_browser_fingerprinting,
  COUNT(DISTINCT IF(category = "Browser fingerprinting", url, NULL)) / COUNT(DISTINCT url) AS pct_websites_with_browser_fingerprinting,
  COUNT(DISTINCT IF(category = "Retargeting", url, NULL)) AS number_of_websites_with_retargeting,
  COUNT(DISTINCT IF(category = "Retargeting", url, NULL)) / COUNT(DISTINCT url) AS pct_websites_with_retargeting,
  COUNT(DISTINCT IF(category = "Geolocation", url, NULL)) AS number_of_websites_with_geolocation,
  COUNT(DISTINCT IF(category = "Geolocation", url, NULL)) / COUNT(DISTINCT url) AS pct_websites_with_geolocation
FROM `httparchive.technologies.2021_07_01_*`
GROUP BY
  client
ORDER BY
  client
