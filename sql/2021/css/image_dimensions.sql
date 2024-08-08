#standardSQL
# CSS-initiated image px dimensions
SELECT
  percentile,
  client,
  APPROX_QUANTILES(height, 1000)[OFFSET(percentile * 10)] AS height,
  APPROX_QUANTILES(width, 1000)[OFFSET(percentile * 10)] AS width,
  APPROX_QUANTILES(area, 1000)[OFFSET(percentile * 10)] AS area
FROM (
  SELECT
    client,
    height,
    width,
    height * width AS area
  FROM (
    SELECT
      client,
      page,
      url AS img_url,
      JSON_VALUE(payload, '$._initiator') AS css_url
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2021-07-01' AND
      type = 'image'
  )
  JOIN (
    SELECT
      client,
      page,
      url AS css_url
    FROM
      `httparchive.almanac.requests`
    WHERE
      date = '2021-07-01' AND
      type = 'css'
  )
  USING (client, page, css_url)
  JOIN (
    SELECT
      _TABLE_SUFFIX AS client,
      url AS page,
      JSON_EXTRACT_SCALAR(image, '$.url') AS img_url,
      SAFE_CAST(JSON_EXTRACT_SCALAR(image, '$.naturalHeight') AS INT64) AS height,
      SAFE_CAST(JSON_EXTRACT_SCALAR(image, '$.naturalWidth') AS INT64) AS width
    FROM
      `httparchive.pages.2021_07_01_*`,
      UNNEST(JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._Images'), '$')) AS image
  )
  USING (client, page, img_url)
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
