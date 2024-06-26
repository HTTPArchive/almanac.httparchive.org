#standardSQL
# 13_16a: Web Push adoption stats by eCommerce origins by device

SELECT
  date,
  client,
  COUNT(DISTINCT origin) AS totalECommOrigins,
  COUNTIF(notification_permission_accept IS NOT NULL) AS eCommOriginsWithWebPush,
  COUNTIF(notification_permission_accept IS NOT NULL) / COUNT(DISTINCT origin) AS pct

FROM
  `chrome-ux-report.materialized.metrics_summary`
JOIN (
  SELECT DISTINCT
    IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
    CAST(REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d+)_(\d+)_(\d+).*', r'\1-\2-\3') AS DATE) AS date,
    RTRIM(url, '/') AS origin
  FROM
    `httparchive.technologies.*`
  WHERE
    REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d+)_(\d+)_(\d+).*', r'\1-\2-\3') IN ('2022-06-01', '2021-07-01', '2020-08-01', '2019-07-01') AND
    category = 'Ecommerce' AND (
      app != 'Cart Functionality' AND
      app != 'Google Analytics Enhanced eCommerce'
    )
)
USING (origin, date)
WHERE
  date IN ('2022-06-01', '2021-07-01', '2020-08-01', '2019-07-01')
GROUP BY
  date,
  client
ORDER BY
  date,
  client
