#standardSQL
# Percent of pages using lite-youtube-embed

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS total_pages
  FROM
    `httparchive.summary_pages.2024_06_01_*`
  GROUP BY
    client
),

youtube_embed AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS youtube_embed_pages
  FROM
    `httparchive.technologies.2024_06_01_*`
  WHERE
    app = 'lite-youtube-embed'
  GROUP BY
    client
)

SELECT
  client,
  youtube_embed_pages,
  total_pages,
  youtube_embed_pages / total_pages AS pct_youtube_embed_pages
FROM
  totals
JOIN
  youtube_embed
USING (client)
ORDER BY
  client
