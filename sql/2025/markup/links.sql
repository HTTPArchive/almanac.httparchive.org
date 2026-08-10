WITH links AS (
  SELECT
    client,
    INT64(custom_metrics.wpt_bodies.anchors.rendered.target_blank.total) AS target_blank_total,
    INT64(custom_metrics.wpt_bodies.anchors.rendered.target_blank.noopener_noreferrer) AS target_blank_noopener_noreferrer_total,
    INT64(custom_metrics.wpt_bodies.anchors.rendered.target_blank.noopener) AS target_blank_noopener_total,
    INT64(custom_metrics.wpt_bodies.anchors.rendered.target_blank.noreferrer) AS target_blank_noreferrer_total,
    INT64(custom_metrics.wpt_bodies.anchors.rendered.target_blank.neither) AS target_blank_neither_total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  COUNT(0) AS total,

  # pages with all target _banks including rel="noopener noreferrer"
  COUNTIF(target_blank_total IS NULL OR target_blank_total = target_blank_noopener_noreferrer_total) / COUNT(0) AS pct_always_target_blank_noopener_noreferrer,

  # pages with some target _banks not using rel="noopener noreferrer"
  COUNTIF(target_blank_total > target_blank_noopener_noreferrer_total) / COUNT(0) AS pct_some_target_blank_without_noopener_noreferrer,

  COUNTIF(target_blank_total > 0) / COUNT(0) AS pct_has_target_blank,
  COUNTIF(target_blank_noopener_noreferrer_total > 0) / COUNT(0) AS pct_has_target_blank_noopener_noreferrer,
  COUNTIF(target_blank_noopener_total > 0) / COUNT(0) AS pct_has_target_blank_noopener,
  COUNTIF(target_blank_noreferrer_total > 0) / COUNT(0) AS pct_has_target_blank_noreferrer,
  COUNTIF(target_blank_neither_total > 0) / COUNT(0) AS pct_has_target_blank_neither
FROM
  links
GROUP BY
  client
