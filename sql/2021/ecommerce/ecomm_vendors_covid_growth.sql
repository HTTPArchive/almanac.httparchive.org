#standardSQL
# 13_04: Timeseries to show eCommerce vendors growth acceleration due to Covid-19
# Excluding apps which are not eCommerce platforms/vendors themselves but are used to identify eCommerce sites. These are signals added in Wappalyzer in 2020 to get better idea on % of eCommerce sites but these are not relevant for vendor % market share analysis
# Limiting to top 5000 records to continue further analysis in Google Sheets. Using HAVING clauses based on 'pct' results in missing data for certain months
SELECT
  IF(ENDS_WITH(_TABLE_SUFFIX, '_desktop'), 'desktop', 'mobile') AS client,
  app,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct,
  LEFT(_TABLE_SUFFIX, 4) AS year,
  SUBSTR(_TABLE_SUFFIX, 6, 2) AS month
FROM
  `httparchive.technologies.*`
JOIN
  (SELECT
      _TABLE_SUFFIX,
      COUNT(DISTINCT url) AS total
    FROM
      `httparchive.summary_pages.*`
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
  year,
  month,
  total
ORDER BY
  pct DESC,
  client DESC,
  app DESC
LIMIT 5000
