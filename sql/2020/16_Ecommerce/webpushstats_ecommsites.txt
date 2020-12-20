#standardSQL
# 13_16a: Web Push Notification CRUX stats (min / max / median) for eCommerce origins

 SELECT
    date,
    
    max(notification_permission_accept) As max_notification_permission_accept,
    max(notification_permission_deny) As max_notification_permission_deny,
    max(notification_permission_ignore) As max_notification_permission_ignore,
    max(notification_permission_dismiss) As max_notification_permission_dismiss,
    
    min(notification_permission_accept) As min_notification_permission_accept,
    min(notification_permission_deny) As min_notification_permission_deny,
    min(notification_permission_ignore) As min_notification_permission_ignore,
    min(notification_permission_dismiss) As min_notification_permission_dismiss,   

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
   WHERE date IN ('2020-09-01')
   and notification_permission_accept is not null
   group by 
   date
   