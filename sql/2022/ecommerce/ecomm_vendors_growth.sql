#standardSQL
# 13_04: Timeseries to show eCommerce vendors growth over the year
# Excluding apps which are not eCommerce platforms/vendors themselves but are used to identify eCommerce sites. These are signals added in Wappalyzer in 2020 to get better idea on % of eCommerce sites but these are not relevant for vendor % market share analysis
# Limiting to top 5000 records to continue further analysis in Google Sheets. Using HAVING clauses based on 'pct' results in missing data for certain months
SELECT
  IF(ENDS_WITH(_TABLE_SUFFIX, '_desktop'), 'desktop', 'mobile') AS client,
  REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d+)_(\d+)_(\d+).*', r'\1-\2-\3') AS date,
  app,
  COUNT(DISTINCT url) AS freq,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.technologies.*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(DISTINCT url) AS total
  FROM
    `httparchive.summary_pages.*`
  GROUP BY
    _TABLE_SUFFIX
)
USING (_TABLE_SUFFIX)
WHERE
  _TABLE_SUFFIX >= '2019_07_01' AND
  category = 'Ecommerce' AND (
    app != 'Cart Functionality' AND
    app != 'Google Analytics Enhanced eCommerce'
  )
GROUP BY
  client,
  date,
  app,
  total
HAVING
  pct > 0.0005
ORDER BY
  client,
  date DESC,
  pct DESC,
  app DESC
