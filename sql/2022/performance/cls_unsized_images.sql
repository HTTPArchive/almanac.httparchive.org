WITH lh AS (
  SELECT
    _TABLE_SUFFIX AS client,
    ARRAY_LENGTH(JSON_QUERY_ARRAY(report, '$.audits.unsized-images.details.items')) AS num_unsized_images
  FROM
    `httparchive.lighthouse.2022_06_01_*`
)


SELECT
  percentile,
  client,
  APPROX_QUANTILES(num_unsized_images, 1000)[OFFSET(percentile * 10)] AS num_unsized_images,
  COUNTIF(num_unsized_images > 0) AS pages,
  COUNT(0) AS total,
  COUNTIF(num_unsized_images > 0) / COUNT(0) AS pct
FROM
  lh,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
