#standardSQL
# 04_19: Video player attributes
# Warning: Parsing HTML with regular expressions is a bad idea. This should be a custom metric.
SELECT
  client,
  LOWER(attr) AS attr,
  COUNT(0) AS freq,
  COUNT(DISTINCT page) AS pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_attr,
  total AS total_pages,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_attr,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct_pages
FROM
  `httparchive.almanac.summary_response_bodies`,
  UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)<(video[^>]*)')) AS video,
  UNNEST(REGEXP_EXTRACT_ALL(video, '(?i)(autoplay|autoPictureInPicture|buffered|controls|controlslist|crossorigin|use-credentials|currentTime|disablePictureInPicture|disableRemotePlayback|duration|height|intrinsicsize|loop|muted|playsinline|poster|preload|src|width)')) AS attr
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  date = '2019-07-01' AND
  firstHtml
GROUP BY
  client,
  total,
  attr
ORDER BY
  freq / total_attr DESC
