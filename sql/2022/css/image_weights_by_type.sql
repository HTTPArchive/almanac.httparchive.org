#standardSQL
# CSS-initiated image stats per page (count, weight) by format
SELECT
  percentile,
  client,
  format,
  APPROX_QUANTILES(css_initiated_images_per_page, 1000)[OFFSET(percentile * 10)] AS css_initiated_images_per_page,
  APPROX_QUANTILES(total_css_initiated_image_weight_per_page / 1024, 1000)[OFFSET(percentile * 10)] AS total_css_initiated_image_kbytes_per_page
FROM (
  SELECT
    client,
    format,
    COUNT(0) AS css_initiated_images_per_page,
    SUM(respSize) AS total_css_initiated_image_weight_per_page
  FROM (
    SELECT
      client,
      page,
      JSON_VALUE(payload, '$._initiator') AS url,
      respSize,
      format
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2022-06-01' AND
      type = 'image'
  )
  JOIN (
    SELECT
      client,
      page,
      url
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2022-06-01' AND
      type = 'css'
  )
  USING (client, page, url)
  GROUP BY
    client,
    page,
    format
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client,
  format
ORDER BY
  percentile,
  client,
  css_initiated_images_per_page DESC
