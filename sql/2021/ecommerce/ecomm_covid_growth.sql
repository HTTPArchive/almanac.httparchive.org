#standardSQL
# 13_03: Timeseries to show eCommerce growth acceleration due to Covid-19
# Excluding apps which are not eCommerce platforms/vendors themselves but are used to identify eCommerce sites. These are signals added in Wappalyzer in 2020 to get better idea on % of eCommerce sites but these are not relevant for vendor % market share analysis
SELECT
  IF(ENDS_WITH(_TABLE_SUFFIX, '_desktop'), 'desktop', 'mobile') AS client,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct,
  2021 AS year,
  LEFT(_TABLE_SUFFIX, 2) AS month
FROM
  `httparchive.technologies.2021_*`
JOIN
  (SELECT
      _TABLE_SUFFIX,
      COUNT(DISTINCT url) AS total
    FROM
      `httparchive.summary_pages.2021_*`
    GROUP BY
      _TABLE_SUFFIX)
USING (_TABLE_SUFFIX)
WHERE
  category = 'Ecommerce'
GROUP BY
  client,
  year,
  month,
  total

UNION ALL

SELECT
  IF(ENDS_WITH(_TABLE_SUFFIX, '_desktop'), 'desktop', 'mobile') AS client,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct,
  2020 AS year,
  LEFT(_TABLE_SUFFIX, 2) AS month
FROM
  `httparchive.technologies.2020_*`
JOIN
  (SELECT
      _TABLE_SUFFIX,
      COUNT(DISTINCT url) AS total
    FROM
      `httparchive.summary_pages.2020_*`
    GROUP BY
      _TABLE_SUFFIX)
USING (_TABLE_SUFFIX)
WHERE
  category = 'Ecommerce'
GROUP BY
  client,
  year,
  month,
  total

ORDER BY
  year DESC,
  month DESC
