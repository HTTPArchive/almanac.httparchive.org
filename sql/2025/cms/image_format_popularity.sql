#standardSQL
# Image format popularity BY CMS
# image_format_popularity.sql

SELECT
  client,
  cms,
  ANY_VALUE(pages) AS pages,
  format,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client, cms) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, cms) AS pct
FROM (
  SELECT DISTINCT
    client,
    page AS url,
    technologies.technology AS cms
  FROM
    `httparchive.crawl.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'CMS' AND
    date = '2025-07-01' AND
    is_root_page
)
JOIN (
  SELECT
    client,
    page AS url,
    CASE
      WHEN STRING(summary.mimeType) = 'image/avif' THEN 'avif'
      WHEN STRING(summary.mimeType) = 'image/webp' THEN 'webp'
      WHEN STRING(summary.mimeType) = 'image/jpeg' THEN 'jpg'
      WHEN STRING(summary.mimeType) = 'image/png' THEN 'png'
      WHEN STRING(summary.mimeType) = 'image/gif' THEN 'gif'
      WHEN STRING(summary.mimeType) = 'image/svg+xml' THEN 'svg'
      WHEN STRING(summary.mimeType) = 'image/x-icon' THEN 'ico'
      WHEN STRING(summary.mimeType) = 'image/vnd.microsoft.icon' THEN 'ico'
      WHEN STRING(summary.mimeType) = 'image/jpg' THEN 'jpg'
      WHEN STRING(summary.mimeType) = 'image/bmp' THEN 'bmp'
      WHEN STRING(summary.mimeType) = 'binary/octet-stream' THEN 'binary/octet-stream'
      ELSE 'other/unknown' -- TO handle ANY unexpected formats
    END
      AS format
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND
    type = 'image' AND
    is_root_page
)
USING (client, url)
JOIN (
  SELECT
    client,
    technologies.technology AS cms,
    COUNT(DISTINCT page) AS pages
  FROM
    `httparchive.crawl.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'CMS' AND
    date = '2025-07-01' AND
    is_root_page
  GROUP BY
    client,
    cms
)
USING (client, cms)
WHERE
  pages > 1000
GROUP BY
  client,
  cms,
  format
ORDER BY
  freq DESC
