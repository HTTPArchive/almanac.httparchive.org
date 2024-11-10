#standardSQL
# video 'media' usage
# video_media.sql
# ❕ Added in 2024 kudos to Scott Jehl
# https://httparchive.slack.com/archives/C017HPKG614/p1721853503362079?thread_ts=1721853437.870119&cid=C017HPKG614


WITH totals AS (
  SELECT
    date,
    client,
    is_root_page,
    COUNT(DISTINCT page) AS total_pages
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    type = 'html' AND
    is_main_document
  GROUP BY
    date,
    client,
    is_root_page
),

video AS (
  SELECT
    date,
    client,
    is_root_page,
    page,
    REGEXP_EXTRACT_ALL(response_body, r'<video [\s\S]*?media="([^"]+)" [\s\S]*?</video>') AS video_source_media
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    type = 'html' AND
    is_main_document AND
    REGEXP_EXTRACT(response_body, r'<video[\s\S]*?media="([^*]+)" [\s\S]*?</video>', 1) IS NOT NULL
)

SELECT
  date,
  client,
  is_root_page,
  source_media,
  COUNT(DISTINCT page) AS num_pages,
  total_pages,
  COUNT(DISTINCT page) / total_pages AS pct_pages
FROM
  video,
  UNNEST(video_source_media) AS source_media
INNER JOIN
  totals
USING (date, client, is_root_page)
GROUP BY
  date,
  client,
  is_root_page,
  source_media,
  total_pages
ORDER BY
  date,
  client,
  pct_pages DESC
