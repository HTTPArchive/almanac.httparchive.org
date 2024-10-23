#standardSQL
# Number of picture elements per page
# picture_distribution.sql

SELECT
  percentile,
  client,
  COUNTIF(picture > 0) AS pages,
  COUNT(0) AS total,
  COUNTIF(picture > 0) / COUNT(0) AS pct,
  APPROX_QUANTILES(IF(picture > 0, picture, NULL), 1000)[OFFSET(percentile * 10)] AS picture_elements_per_page
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_QUERY(JSON_VALUE(payload, '$._media'), '$.num_picture_img') AS INT64) AS picture
  FROM
    `httparchive.pages.2024_06_01_*`),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
