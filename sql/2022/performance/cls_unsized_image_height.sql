WITH lh AS (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_VALUE(unsized_image, '$.node.boundingRect.height') AS INT64) AS height
  FROM
    `httparchive.lighthouse.2022_06_01_*`,
    UNNEST(JSON_QUERY_ARRAY(report, '$.audits.unsized-images.details.items')) AS unsized_image
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(height, 1000)[OFFSET(percentile * 10)] AS height,
  COUNT(0) AS unsized_images
FROM
  lh,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
