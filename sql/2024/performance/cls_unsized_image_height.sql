WITH lh AS (
  SELECT
    client,
    CAST(JSON_VALUE(unsized_image, '$.node.boundingRect.height') AS INT64) AS height
  FROM
    `httparchive.all.pages`,
    UNNEST(JSON_QUERY_ARRAY(lighthouse, '$.audits.unsized-images.details.items')) AS unsized_image
  WHERE
    date = '2024-06-01' AND
    is_root_page
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
