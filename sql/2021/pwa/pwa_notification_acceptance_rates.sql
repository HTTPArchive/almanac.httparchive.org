#standardSQL
# 13_16b: Web Push Notification CRUX stats (10th / 25th / 50th / 75th / 90th / 100th percentile) for PWA origins
# Based on https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2020/ecommerce/webpushstats_ecommsites.sql

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
JOIN
  (
    SELECT
      _TABLE_SUFFIX AS client,
      RTRIM(url, "/") AS origin,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    WHERE
      JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = "true"
    GROUP BY
      _TABLE_SUFFIX,
      url
  )
USING
  (origin),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date IN ('2021-07-01') AND
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
  percentile
