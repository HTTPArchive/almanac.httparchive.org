#standardSQL
# Percent of websites using a retargeting library (Based on wappalyzer 'Retargeting' category)
# Alternatively, `core_web_vitals.technologies` could be used, but then we do not have
#  access to the total number of websites

WITH apps AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    IF(category = "Retargeting", app, "") AS retargeting_app
  FROM `httparchive.technologies.2021_07_01_*`
  GROUP BY
    client,
    url,
    retargeting_app
),

base AS (
  SELECT
    client,
    url,
    retargeting_app,
    COUNT(DISTINCT url) OVER (PARTITION BY client) AS total_pages,
    COUNT(DISTINCT url) / COUNT(DISTINCT url) OVER (PARTITION BY 0) AS pct_pages_with_retargeting
  FROM
    apps
  GROUP BY
    client,
    url,
    retargeting_app
)

SELECT
  client,
  retargeting_app,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT url) / ANY_VALUE(total_pages) AS pct_pages_with_retargeting
FROM
  base
WHERE
  retargeting_app != ""
GROUP BY
  client,
  retargeting_app
ORDER BY
  3 DESC
