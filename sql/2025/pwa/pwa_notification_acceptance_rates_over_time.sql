#standardSQL
# Total Notification Acceptance Rates across all origins — 2025
# Unweighted by origin popularity; logic identical to 2022

SELECT
  date,
  IF(device = 'phone', 'mobile', device) AS client,
  SUM(notification_permission_accept) / SUM(notification_permission_accept + notification_permission_deny + notification_permission_ignore + notification_permission_dismiss) AS accept,
  SUM(notification_permission_deny) / SUM(notification_permission_accept + notification_permission_deny + notification_permission_ignore + notification_permission_dismiss) AS deny,
  SUM(notification_permission_ignore) / SUM(notification_permission_accept + notification_permission_deny + notification_permission_ignore + notification_permission_dismiss) AS _ignore,
  SUM(notification_permission_dismiss) / SUM(notification_permission_accept + notification_permission_deny + notification_permission_ignore + notification_permission_dismiss) AS dismiss
FROM
  `chrome-ux-report.materialized.device_summary`
WHERE (
  notification_permission_accept IS NOT NULL OR
  notification_permission_deny IS NOT NULL OR
  notification_permission_ignore IS NOT NULL OR
  notification_permission_dismiss IS NOT NULL
) AND device IN ('desktop', 'phone')
GROUP BY
  date,
  device
ORDER BY
  date DESC,
  device;
