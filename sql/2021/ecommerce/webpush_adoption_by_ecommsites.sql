#standardSQL
# 13_16a: Web Push adoption stats by eCommerce origins by device

SELECT
  client,
  COUNT(DISTINCT origin) AS totalECommOrigins,
  COUNTIF(notification_permission_accept IS NOT NULL) AS eCommOriginsWithWebPush,
  COUNTIF(notification_permission_accept IS NOT NULL) / COUNT(DISTINCT origin) AS pct

FROM
  `chrome-ux-report.materialized.metrics_summary`
JOIN (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    RTRIM(url, '/') AS origin
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = 'Ecommerce' AND (
      app != 'Cart Functionality' AND
      app != 'Google Analytics Enhanced eCommerce'
    )
)
USING (origin)
WHERE
  date IN ('2021-07-01')
GROUP BY
  client
ORDER BY
  client
