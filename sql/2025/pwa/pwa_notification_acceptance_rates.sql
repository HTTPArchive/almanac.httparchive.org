#standardSQL
# Web Push Notification CRUX stats (10/25/50/75/90/100) for PWA origins — 2025
# Only crawl dataset update; logic identical to 2022

SELECT
  date,
  client,
  percentile,
  APPROX_QUANTILES(notification_permission_accept, 1000 RESPECT NULLS)[OFFSET(percentile * 10)] AS notification_permission_accept,
  APPROX_QUANTILES(notification_permission_deny, 1000 RESPECT NULLS)[OFFSET(percentile * 10)] AS notification_permission_deny,
  APPROX_QUANTILES(notification_permission_ignore, 1000 RESPECT NULLS)[OFFSET(percentile * 10)] AS notification_permission_ignore,
  APPROX_QUANTILES(notification_permission_dismiss, 1000 RESPECT NULLS)[OFFSET(percentile * 10)] AS notification_permission_dismiss
FROM
  `chrome-ux-report.materialized.metrics_summary`
JOIN (
  SELECT
    client,
    RTRIM(page, '/') AS origin,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    JSON_VALUE(custom_metrics.other.pwa.serviceWorkerHeuristic) = 'true'
  GROUP BY
    client,
    origin
) p
USING (origin),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date IN ('2025-07-01') AND
  (
    notification_permission_accept IS NOT NULL OR
    notification_permission_deny IS NOT NULL OR
    notification_permission_ignore IS NOT NULL OR
    notification_permission_dismiss IS NOT NULL
  )
GROUP BY
  date,
  client,
  percentile
ORDER BY
  date,
  client,
  percentile;
