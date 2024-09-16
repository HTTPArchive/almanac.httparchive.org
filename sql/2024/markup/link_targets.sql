WITH bodies AS (
  SELECT
    client,
    JSON_EXTRACT(custom_metrics, '$.wpt_bodies') AS wpt_bodies
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
), links AS (
  SELECT
    client,
    SAFE_CAST(JSON_EXTRACT(wpt_bodies, '$.anchors.rendered.target_blank.total') AS INT64) AS target_blank_total,
    SAFE_CAST(JSON_EXTRACT(wpt_bodies, '$.anchors.rendered.target_blank.noopener_noreferrer') AS INT64) AS target_blank_noopener_noreferrer_total,
    SAFE_CAST(JSON_EXTRACT(wpt_bodies, '$.anchors.rendered.target_blank.noopener') AS INT64) AS target_blank_noopener_total,
    SAFE_CAST(JSON_EXTRACT(wpt_bodies, '$.anchors.rendered.target_blank.noreferrer') AS INT64) AS target_blank_noreferrer_total,
    SAFE_CAST(JSON_EXTRACT(wpt_bodies, '$.anchors.rendered.target_blank.neither') AS INT64) AS target_blank_neither_total
  FROM
    bodies
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
