#standardSQL
# 13_16b: Web Push Notification CRUX stats (10th / 25th / 50th / 75th / 90th / 100th percentile) for eCommerce origins

 SELECT
  date,
  client,

  ROUND(APPROX_QUANTILES(notification_permission_accept, 1000 RESPECT NULLS)[OFFSET(100)], 3) AS notification_permission_accept_10th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_accept, 1000 RESPECT NULLS)[OFFSET(250)], 3) AS notification_permission_accept_25th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_accept, 1000 RESPECT NULLS)[OFFSET(500)], 3) AS notification_permission_accept_50th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_accept, 1000 RESPECT NULLS)[OFFSET(750)], 3) AS notification_permission_accept_75th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_accept, 1000 RESPECT NULLS)[OFFSET(900)], 3) AS notification_permission_accept_90th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_accept, 1000 RESPECT NULLS)[OFFSET(1000)], 3) AS notification_permission_accept_100th_percentile,

  ROUND(APPROX_QUANTILES(notification_permission_deny, 1000 RESPECT NULLS)[OFFSET(100)], 3) AS notification_permission_deny_10th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_deny, 1000 RESPECT NULLS)[OFFSET(250)], 3) AS notification_permission_deny_25th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_deny, 1000 RESPECT NULLS)[OFFSET(500)], 3) AS notification_permission_deny_50th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_deny, 1000 RESPECT NULLS)[OFFSET(750)], 3) AS notification_permission_deny_75th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_deny, 1000 RESPECT NULLS)[OFFSET(900)], 3) AS notification_permission_deny_90th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_deny, 1000 RESPECT NULLS)[OFFSET(1000)], 3) AS notification_permission_deny_100th_percentile,

  ROUND(APPROX_QUANTILES(notification_permission_ignore, 1000 RESPECT NULLS)[OFFSET(100)], 3) AS notification_permission_ignore_10th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_ignore, 1000 RESPECT NULLS)[OFFSET(250)], 3) AS notification_permission_ignore_25th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_ignore, 1000 RESPECT NULLS)[OFFSET(500)], 3) AS notification_permission_ignore_50th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_ignore, 1000 RESPECT NULLS)[OFFSET(750)], 3) AS notification_permission_ignore_75th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_ignore, 1000 RESPECT NULLS)[OFFSET(900)], 3) AS notification_permission_ignore_90th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_ignore, 1000 RESPECT NULLS)[OFFSET(1000)], 3) AS notification_permission_ignore_100th_percentile,

  ROUND(APPROX_QUANTILES(notification_permission_dismiss, 1000 RESPECT NULLS)[OFFSET(100)], 3) AS notification_permission_dismiss_10th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_dismiss, 1000 RESPECT NULLS)[OFFSET(250)], 3) AS notification_permission_dismiss_25th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_dismiss, 1000 RESPECT NULLS)[OFFSET(500)], 3) AS notification_permission_dismiss_50th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_dismiss, 1000 RESPECT NULLS)[OFFSET(750)], 3) AS notification_permission_dismiss_75th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_dismiss, 1000 RESPECT NULLS)[OFFSET(900)], 3) AS notification_permission_dismiss_90th_percentile,
  ROUND(APPROX_QUANTILES(notification_permission_dismiss, 1000 RESPECT NULLS)[OFFSET(1000)], 3) AS notification_permission_dismis_100th_percentiles

 FROM
  `chrome-ux-report.materialized.metrics_summary`
 JOIN (
    SELECT DISTINCT
      _TABLE_SUFFIX AS client,
      RTRIM(url, "/") AS origin
    FROM
      `httparchive.technologies.2020_08_01_*`
    WHERE category = 'Ecommerce')
 USING
  (origin)
 WHERE date IN ('2020-08-01') AND
  notification_permission_accept IS NOT NULL
 GROUP BY
  date,
  client
 ORDER BY
  date,
  client
