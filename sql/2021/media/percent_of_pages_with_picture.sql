WITH number_of_pictures_per_page AS (
SELECT
    _TABLE_SUFFIX AS client,
   url,
   CAST( JSON_VALUE( JSON_VALUE( payload, "$._media" ), "$.num_picture_img") AS INT64 ) AS num_picture_img
FROM
  `httparchive.sample_data.pages_*`
),
total_number_of_pages AS(
SELECT
    client,
    COUNT(0) AS total_pages
FROM number_of_pictures_per_page
GROUP BY client
),
number_of_pages_with_picture_elements AS (
SELECT
    client,
    COUNT(0) AS total_pages_with_picture
FROM number_of_pictures_per_page
WHERE num_picture_img > 0
GROUP BY client
)
SELECT
    client,
    total_pages,
    total_pages_with_picture,
    SAFE_DIVIDE( total_pages_with_picture, total_pages ) AS percent_of_pages_with_picture
FROM total_number_of_pages
    JOIN number_of_pages_with_picture_elements
    USING (client)
