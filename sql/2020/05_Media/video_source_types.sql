#standardSQL
# get video source types
# TODO: replace sample_data with the real data when done

SELECT client,
  video_source as video_type,
  count(0) as video_type_count
FROM
  (
  SELECT
    client,
    page,
    video_source
  FROM
    `httparchive.sample_data.summary_response_bodies_firstHtml`,
    UNNEST(regexp_extract_ALL(body, r'<video[^><]*>.*?<source[^><]*type=(?:"|\')*video/([^"|\'|\\s|>]*)(?:"|\'|\\s|>).*?</video>')) as video_source
  )
GROUP BY
  client, video_source
ORDER BY
  client, video_type_count desc;
