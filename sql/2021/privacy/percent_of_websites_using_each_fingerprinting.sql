#standardSQL
# Percent of websites using a fingerprinting library (Based on wappalyzer 'Browser fingerprinting' category)
# Alternatively, `core_web_vitals.technologies` could be used, but then we do not have
#  access to the total number of websites

WITH apps AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    IF(category = "Browser fingerprinting", app, "") AS fingerprinting_app
  FROM `httparchive.technologies.2021_08_01_*`
  GROUP BY
    client,
    url,
    fingerprinting_app
), base AS (
  SELECT
    client,
    url,
    fingerprinting_app,
    COUNT(DISTINCT url) OVER (PARTITION BY client) AS total_pages,
    COUNT(DISTINCT url) / COUNT(DISTINCT url) OVER () AS pct_pages_with_fingerprinting,
  FROM
    apps
  GROUP BY
    client,
    url,
    fingerprinting_app
)

SELECT
  client,
  fingerprinting_app,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT url) / ANY_VALUE(total_pages) AS pct_pages_with_fingerprinting,
FROM
  base
WHERE
  fingerprinting_app != ""
GROUP BY
  client,
  fingerprinting_app