#standardSQL
# 13_01: Top ecommerce vendors by device
# Excluding apps which are not eCommerce platforms/vendors themselves but are used to identify eCommerce sites. These are signals added in Wappalyzer in 2020 to get better idea on % of eCommerce sites but these are not relevant for vendor % market share analysis
SELECT
  _TABLE_SUFFIX AS client,
  app,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.technologies.2020_08_01_*`
JOIN
  (SELECT
      _TABLE_SUFFIX,
      COUNT(DISTINCT url) AS total
    FROM
      `httparchive.summary_pages.2020_08_01_*`
    GROUP BY
      _TABLE_SUFFIX)
USING (_TABLE_SUFFIX)
WHERE
  category = 'Ecommerce' AND
  (app != 'Cart Functionality' AND
   app != 'Google Analytics Enhanced eCommerce')
GROUP BY
  client,
  app,
  total
ORDER BY
  client DESC,
  pct DESC
LIMIT 1000
