#standardSQL
# non custom metrics sql that uses regexp on response bodies
# TODO: replace sample database with the real one when done
# img src vs data-uri
# count rel=preconnect
SELECT client,
  count(0) as total,
  countif(has_img_data_uri) as has_img_data_uri,
  countif(has_img_src) as has_img_src,
  countif(rel_preconnect) as rel_preconnect
FROM
  (
  SELECT
    client,
    page,
    regexp_contains(body, r'<img[^><]*src=(?:\"|\')*data[:]image/(?:\"|\')*[^><]*>') as has_img_data_uri,
    regexp_contains(body, r'<img[^><]*src=[^><]*>') as has_img_src,
    regexp_contains(body, r'<link[^><]*rel=(?:\"|\')*preconnect/(?:\"|\')*[^><]*>') as rel_preconnect
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
