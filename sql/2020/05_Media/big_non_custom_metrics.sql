#standardSQL
# non custom metrics sql that uses regexp on response bodies
# img src vs data-uri
# count rel=preconnect
# video with src
# video with source
# figure
# figure with figcaption

SELECT client,
  COUNTIF(has_img_data_uri) / COUNTIF(has_img_src) AS pages_with_img_data_uri_pct,
  COUNTIF(rel_preconnect) / COUNT(0) AS pages_with_rel_preconnect_pct,
  COUNTIF(has_video_src) / COUNT(0) AS pages_with_video_src_pct,
  COUNTIF(has_video_source) / COUNT(0) AS pages_with_video_source_pct,
  COUNTIF(has_figure) / COUNT(0) AS pages_with_figure_pct,
  COUNTIF(has_figcaption) / COUNT(0) AS pages_with_figcaption_pct
FROM
  (
  SELECT
    client,
    page,
    regexp_contains(body, r'<img[^><]*src=(?:\"|\')*data[:]image/(?:\"|\')*[^><]*>') as has_img_data_uri,
    regexp_contains(body, r'<img[^><]*src=[^><]*>') as has_img_src,
    regexp_contains(body, r'<link[^><]*rel=(?:\"|\')*preconnect/(?:\"|\')*[^><]*>') as rel_preconnect,
    regexp_contains(body, r'<video[^><]*src=[^><]*>') as has_video_src,
    regexp_contains(body, r'<video[^><]*>.*?<source[^><]*>.*?</video>') as has_video_source,
    regexp_contains(body, r'<figure[^><]*>') as has_figure,
    regexp_contains(body, r'<figure[^><]*>.*?<figcaption[^><]*>.*?</figure>') as has_figcaption
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2020-08-01' AND
    firstHtml
  )
GROUP BY
  client
ORDER BY
  client;
