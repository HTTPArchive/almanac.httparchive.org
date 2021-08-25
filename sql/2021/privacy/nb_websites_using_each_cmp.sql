#standardSQL
# Percent of websites using a specific CMP (Based on wappalyzer 'Cookie compliance' category)
# Alternatively, `core_web_vitals.technologies` could be used, but then we do not have
#  access to the total number of websites

WITH apps AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    IF(category = "Cookie compliance", app, "") AS cmp_app
  FROM `httparchive.technologies.2021_07_01_*`
  GROUP BY
    client,
    url,
    cmp_app
),

base AS (
  SELECT
    client,
    url,
    cmp_app,
    COUNT(DISTINCT url) OVER (PARTITION BY client) AS total_pages,
    COUNT(DISTINCT url) / COUNT(DISTINCT url) OVER (PARTITION BY 0) AS pct_pages_with_cmp
  FROM
    apps
  GROUP BY
    client,
    url,
    cmp_app
)

SELECT
  client,
  cmp_app,
  ANY_VALUE(total_pages) AS total_pages,
  COUNT(DISTINCT url) / ANY_VALUE(total_pages) AS pct_pages_with_cmp
FROM
  base
WHERE
  cmp_app != ""
GROUP BY
  client,
  cmp_app
ORDER BY
  3 DESC
