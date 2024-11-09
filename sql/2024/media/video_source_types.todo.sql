#standardSQL
# What types are most common?

SELECT
  client,
  LOWER(video_type) AS video_type,
  COUNT(0) AS video_type_count,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS video_type_pct
FROM
  `httparchive.all.requests`,
  UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)(<video.*?</video>)')) AS video,
  UNNEST(REGEXP_EXTRACT_ALL(video, r'(?i)type\s*=\s*["\'](video/[^\'";?]*)')) AS video_type
WHERE
  date = '2022-06-01' AND
  type = 'html' AND
  is_main_document
GROUP BY
  client,
  video_type
ORDER BY
  client,
  video_type_count DESC
