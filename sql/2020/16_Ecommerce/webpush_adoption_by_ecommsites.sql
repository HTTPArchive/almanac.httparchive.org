#standardSQL
# 13_16a: Web Push adoption stats by eCommerce origins

 SELECT
    COUNT(DISTINCT origin) as totalECommOrigins,
    COUNTIF(notification_permission_accept IS NOT NULL) AS eCommOriginsWithWebPush,
    COUNTIF(notification_permission_accept IS NOT NULL) / COUNT(DISTINCT origin) AS pct
    
  FROM
    `chrome-ux-report.materialized.metrics_summary`
  JOIN (
    SELECT
      DISTINCT RTRIM(url, "/") AS origin
    FROM
      `httparchive.technologies.2020_08_01_*`
    WHERE category = 'Ecommerce')
  USING
    (origin)
  WHERE date IN ('2020-08-01') 
