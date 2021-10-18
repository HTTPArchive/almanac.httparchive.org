SELECT
  client,
  COUNTIF(numOfImages > 0) AS number_of_pages_with_picture_elements,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_number_of_pages,
  COUNTIF(numOfImages > 0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS percent_of_pages_with_picture_elements
FROM (
    SELECT
        _TABLE_SUFFIX AS client,
        CAST(JSON_VALUE(JSON_VALUE(payload, "$._media" ), "$.num_picture_img") AS INT64) AS numOfImages
    FROM
        `httparchive.sample_data.pages_*`
)
GROUP BY
  client
