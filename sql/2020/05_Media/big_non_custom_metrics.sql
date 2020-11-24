#standardSQL
# non custom metrics sql that uses regexp on response bodies
# TODO: replace sample database with the real one when done
# img src vs data-uri
# count rel=preconnect
# video with src
# video with source
SELECT client,
  COUNT(0) as total,
  COUNTIF(has_img_data_uri) AS has_img_data_uri,
  COUNTIF(has_img_src) AS has_img_src,
  COUNTIF(rel_preconnect) AS rel_preconnect,
  COUNTIF(has_video_src) AS has_video_src,
  COUNTIF(has_video_source) AS has_video_source
FROM
  (
  SELECT
    client,
    page,
    regexp_contains(body, r'<img[^><]*src=(?:\"|\')*data[:]image/(?:\"|\')*[^><]*>') as has_img_data_uri,
    regexp_contains(body, r'<img[^><]*src=[^><]*>') as has_img_src,
    regexp_contains(body, r'<link[^><]*rel=(?:\"|\')*preconnect/(?:\"|\')*[^><]*>') as rel_preconnect,
    regexp_contains(body, r'<video[^><]*src=[^><]*>') as has_video_src,
    regexp_contains(body, r'<video[^><]*>.*?<source[^><]*>.*?</video>') as has_video_source
  FROM
    `httparchive.sample_data.summary_response_bodies_firstHtml`
  WHERE
    date = '2020-08-01' AND
    firstHtml
  )
GROUP BY
  client
ORDER BY
  client;
