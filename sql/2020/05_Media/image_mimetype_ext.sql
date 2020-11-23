#standardSQL
# images mimetype vs extension
SELECT
  client,
  COUNT(0) AS image_count,
  ext,
  mimetype
FROM
  (
  SELECT
    client,
    url,
    mimetype,
    ext
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2020-08-01' and type='image'
  # some images show up multiple times with the same info  
  GROUP BY
    client, url, mimetype, ext
  )
GROUP BY
  client, ext, mimetype
order by
  total_images desc;
