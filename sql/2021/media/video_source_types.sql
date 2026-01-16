#standardSQL
# get video source types

SELECT
  client,
  LOWER(video_type) AS video_type,
  COUNT(0) AS video_type_count,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS video_type_pct
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)(<video.*?</video>)')) AS video,
  UNNEST(REGEXP_EXTRACT_ALL(video, r'(?i)type\s*=\s*["\'](video/[^\'";?]*)')) AS video_type
WHERE
  date = '2021-08-01' AND -- noqa: CV09
  firstHtml
GROUP BY
  client,
  video_type
ORDER BY
  client,
  video_type_count DESC
