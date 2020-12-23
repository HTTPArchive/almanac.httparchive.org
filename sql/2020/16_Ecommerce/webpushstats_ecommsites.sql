#standardSQL
# 13_16b: Web Push Notification CRUX stats (min / max / median) for eCommerce origins

 SELECT
    date,
    
    MAX(notification_permission_accept) AS max_notification_permission_accept,
    MAX(notification_permission_deny) AS max_notification_permission_deny,
    MAX(notification_permission_ignore) AS max_notification_permission_ignore,
    MAX(notification_permission_dismiss) AS max_notification_permission_dismiss,
    
    MIN(notification_permission_accept) AS min_notification_permission_accept,
    MIN(notification_permission_deny) AS min_notification_permission_deny,
    MIN(notification_permission_ignore) AS min_notification_permission_ignore,
    MIN(notification_permission_dismiss) AS min_notification_permission_dismiss,   

    APPROX_QUANTILES(notification_permission_accept, 1000 RESPECT NULLS)[OFFSET(500)] AS median_notification_permission_accept,
    APPROX_QUANTILES(notification_permission_deny, 1000 RESPECT NULLS)[OFFSET(500)] AS median_notification_permission_deny,
    APPROX_QUANTILES(notification_permission_ignore, 1000 RESPECT NULLS)[OFFSET(500)] AS median_notification_permission_ignore,
    APPROX_QUANTILES(notification_permission_dismiss, 1000 RESPECT NULLS)[OFFSET(500)] AS median_notification_permission_dismiss
    
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
WHERE date IN ('2020-08-01') AND
  notification_permission_accept IS NOT NULL
GROUP BY
  date
