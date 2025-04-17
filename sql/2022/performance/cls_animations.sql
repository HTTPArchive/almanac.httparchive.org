WITH lh AS (
  SELECT
    _TABLE_SUFFIX AS client,
    ARRAY_LENGTH(JSON_QUERY_ARRAY(report, '$.audits.non-composited-animations.details.items')) AS num_animations
  FROM
    `httparchive.lighthouse.2022_06_01_*`
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(num_animations, 1000)[OFFSET(percentile * 10)] AS num_animations,
  COUNTIF(num_animations > 0) AS pages,
  COUNT(0) AS total,
  COUNTIF(num_animations > 0) / COUNT(0) AS pct
FROM
  lh,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
